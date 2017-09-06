reader = angular.module('atmfReader', ['angular-carousel', 'ngAudio', 'ngSanitize'])

## Controller
reader.controller('ReaderController', [ '$scope', '$sce', '$location', 'OpusService', '$rootScope', 'MusicService', 'VoiceService', ($scope, $sce, $location, OpusService, $rootScope, MusicService, VoiceService) ->
  url = $location.absUrl()
  regex = /\/catalog\/([0-9]+)/i
  match = regex.exec(url)
  
  if match
    opus_id = match[1]
  $scope.opus = OpusService.get(opus_id).then (response) ->
    $scope.opus = response.data
    $scope.opus.chapters_attributes.map( (chapter) ->
      chapter.content = $sce.trustAsHtml(chapter.content)
    )

    $scope.currentChapter = -1
    $scope.slider = []

    $scope.sliderClicked = false
    $scope.isSliderOpen = []

    $scope.getBackground = (color) ->
      color = color[1 .. color.length]
      if (luma(color) >= 165) 
        return "background-color: rgba(0, 0, 0, 0.4)" 
      else 
        return "background-color: rgba(255, 255, 255, 0.4)"  

    luma = (color) ->
      rgb = if typeof color == 'string' then hexToRGBArray(color) else color
      0.2126 * rgb[0] + 0.7152 * rgb[1] + 0.0722 * rgb[2]
      # SMPTE C, Rec. 709 weightings

    hexToRGBArray = (color) ->
      if color.length == 3
        color = color.charAt(0) + color.charAt(0) + color.charAt(1) + color.charAt(1) + color.charAt(2) + color.charAt(2)
      else if color.length != 6
        throw 'Invalid hex color: ' + color
      rgb = []
      i = 0
      while i <= 2
        rgb[i] = parseInt(color.substr(i * 2, 2), 16)
        i++
      rgb



    $scope.openSlider = (index) ->
      $scope.isSliderOpen[index] = true
      $scope.sliderClicked = true

    $scope.closeSlider = () ->
      angular.forEach($scope.opus.chapters_attributes, (chapter, i) ->
        $scope.isSliderOpen[i] = false
      )
      $scope.sliderClicked = false


    $scope.musicOpen = false
    $scope.toggleMusic = () ->
      $scope.musicOpen = $scope.musicOpen == false ? true : false
      $scope.voiceOpen = false
      $scope.menuOpen = false

    $scope.voiceOpen = false
    $scope.toggleVoice = () ->
      $scope.voiceOpen = $scope.voiceOpen == false ? true : false
      $scope.musicOpen = false
      $scope.menuOpen = false

    $scope.menuOpen = false
    $scope.toggleMenu = () ->
      $scope.menuOpen = $scope.menuOpen == false ? true : false
      $scope.voiceOpen = false
      $scope.musicOpen = false

    $scope.closeMenus = () ->
      $scope.menuOpen = false
      $scope.voiceOpen = false
      $scope.musicOpen = false    


    $scope.currentVoice = ""
    $scope.currentMusic = ""

    $scope.playMusic = (index) ->
      $scope.opus.musics_attributes[index].$loading = true
      url = $scope.opus.musics_attributes[index].file.url
      MusicService.play(url).then( ->
        $scope.opus.musics_attributes[index].$loading = false
        $scope.currentMusic = $scope.opus.musics_attributes[index]
      )

    $scope.pauseMusic = () ->
      MusicService.pause()
      $scope.currentMusic = ""

    $scope.isMusicPlaying = (index) ->
      if $scope.musics_attributes
        if MusicService.nowPlaying() == $scope.musics_attributes[index].file.url 
          return true

    $scope.playVoice = (index) ->
      $scope.opus.voices_attributes[index].$loading = true
      url = $scope.opus.voices_attributes[index].file.url
      VoiceService.play(url).then( ->
        $scope.opus.voices_attributes[index].$loading = false
        $scope.currentVoice = $scope.opus.voices_attributes[index]
      )

    $scope.pauseVoice = () ->
      VoiceService.pause()
      $scope.currentVoice = ""

    $scope.isVoicePlaying = (index) ->
      if $scope.voices_attributes
        if VoiceService.nowPlaying() == $scope.opus.voices_attributes[index].file.url 
          return true

    # $scope.duration = (url) ->
    #   return MusicService.getSongDuration(url)


    # preload images
    if (document.images)
      images = []
      angular.forEach($scope.opus.chapters_attributes, (chapter, j) ->
        angular.forEach(chapter.slider_entries_attributes, (image, i) ->
          images[i] = new Image();
          images[i].src = image.file.url
        )
      )

    # Set current chapter in real time
    $( () ->
      currentChapter = null
      lastPos = null

      getCurrentChapter = () ->
        visibleChapters = []
        windowMiddle = $(window).height()  / 2
        $('section').each( () ->
          if ( $(this).offset().top <= ( $(window).scrollTop() + windowMiddle ) )
            visibleChapters.push( $(this) )
        )
        last = visibleChapters[visibleChapters.length - 1]
        nextChapter = last.attr('id')
        return last.attr("data-position")

      checkChapter = () ->
        scrollTop = $(window).scrollTop()
        if (scrollTop != lastPos)
          nextChapter = getCurrentChapter()

          if (currentChapter != nextChapter) 
            $rootScope.$broadcast( 'chapterChanged', {
              'currentChapter': nextChapter
            })
          currentChapter = nextChapter
        lastPos = scrollTop

      checkChapterID = setInterval(checkChapter, 50)
    )

    # change images on chapter change
    $scope.$on('chapterChanged', (event, e) ->
      $scope.currentChapter = e.currentChapter
      $scope.$digest()
    )
    $scope.notImplemented = () ->
      alert("Cette fonctionnalité n'existe pas encore")

])

## ScrollTop
reader.directive 'scrollTop', () ->
  {
    restrict: 'A'
    link: (scope, $elm) ->
      $elm.on 'click', () ->
        $("body").animate({scrollTop: 0}, "slow")
  }

## MusicService
reader.factory('MusicService', [ '$q', ($q) ->
  audio = document.createElement('audio')
  MASTER_VOLUME = 0.1
  MusicService = {
    play: (url) ->
      deferred = $q.defer()
      if (url != audio.getAttribute('src'))
        audio.setAttribute("src", url)
        audio.addEventListener('loadedmetadata', () ->
          audio.volume = MASTER_VOLUME
          audio.play()
          deferred.resolve(true)
        )
      else
        audio.volume = MASTER_VOLUME
        audio.play()
        deferred.resolve(true)

      return deferred.promise
    pause: () ->
      audio.pause()

    nowPlaying: () ->
      if !audio.paused
        return audio.src
  }
])

## VoiceService
reader.factory('VoiceService', [ '$q', ($q) ->
  audio = document.createElement('audio')
  VoiceService = {
    play: (url) ->
      deferred = $q.defer()
      if (url != audio.getAttribute('src'))
        audio.setAttribute("src", url)
        audio.addEventListener('loadedmetadata', () ->
          audio.volume = 0.5
          audio.play()
          deferred.resolve(true)
        )
      else
        audio.volume = 0.5
        audio.play()
        deferred.resolve(true)

      return deferred.promise
    pause: () ->
      audio.pause()

    nowPlaying: () ->
      if !audio.paused
        return audio.src
        
    # getCurrentTime: () ->
    #   return audio.currentTime.toFixed(2)

    # getSongDuration: (url) ->
    #   console.log "started"
    #   deferred = $q.defer()
    #   tmp = document.createElement('audio')
    #   tmp.src = url
    #   tmp.addEventListener('loadedmetadata', () ->
    #     console.log "duration"
    #     deferred.resolve(VoiceService.toMMSS(tmp.duration))
    #   )
    #   return deferred.promise


    toMMSS: (sec) ->
      sec_num = parseInt(sec, 10)
      hours   = Math.floor(sec_num / 3600)
      minutes = Math.floor((sec_num - (hours * 3600)) / 60)
      seconds = sec_num - (hours * 3600) - (minutes * 60)

      if (minutes < 10) 
        minutes = "0"+minutes
      if (seconds < 10) 
        seconds = "0"+seconds
      time    = minutes+':'+seconds;
      return time
  }
])

reader.filter 'classify', () ->
  return (str) ->
    if (str)
      return str.toLowerCase().replace(/\+/g, '-')



## OpusService
reader.factory('OpusService', [ '$http', ($http) ->
  OpusService = {
    get: (opus_id) ->
      $http.get('/catalog/' + opus_id + '/preview.json')
      
  }

])