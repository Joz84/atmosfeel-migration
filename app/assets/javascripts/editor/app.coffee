app = angular.module('AtmEditor', ['angularFileUpload', 'ng-rails-csrf', 'ui.select', 'ngSanitize', 'farbtastic', 'colorpicker.module', 'wysiwyg.module'])

app.controller('MainCtrl', ['$scope', 'OpusService', '$http', '$location', '$upload', '$q', '$window', '$anchorScroll', ($scope, OpusService, $http, $location, $upload, $q, $window, $anchorScroll) ->

  # wysiwyg
  $scope.menu = [
    ['left-justify', 'center-justify', 'right-justify'],
    ['link']
  ]

  url = $location.absUrl()
  regex = /\/opuses\/([0-9]+)\/edit/i
  match = regex.exec(url)

  if match
    opus_id = match[1]
  else 
    opus_id = null


  promises = []
  if opus_id != null
    get = OpusService.get(opus_id).then( (response) ->
      $scope.opus = response.data
    )
    promises.push(get)
  else
    $scope.opus = {
      atmosphere_id: 1,
      play_time_id: 1,
      price: 0.00,
      title: "",
      abstract: "",
      font_color: "#000000",
      font_family: "Open+Sans",
      language_id: 1,
      cover: {},
      musics_attributes: [],
      voices_attributes: [],
      keyword_opuses_attributes: [],
      collaborations_attributes: [],
      chapters_attributes: []
    }

  $q.all(promises).then( () -> 
    $scope.hide_overlay = true

    ## MUSIC
    $scope.addMusic = (root_item) ->
      root_item.musics_attributes.push({})

    $scope.uploadMusic = ($files, $event, $rejected, root_item, $index) ->
      
      $upload.upload({
        url: '/api/files',
        file: $files[0]
      }).progress( (evt)  ->
        root_item.musics_attributes[$index].spinner = true
      ).success( (data) ->
        root_item.musics_attributes[$index].local_file = data.path
        root_item.musics_attributes[$index].spinner = false
      )

    $scope.removeMusic = (root_item, $index) ->
      root_item.musics_attributes[$index]._destroy = 1
      root_item.musics_attributes[$index].file.url = null
      root_item.musics_attributes[$index].local_file = null


    $scope.outOfMusic = (root_item) ->
      if !root_item.musics_attributes || root_item.musics_attributes.length <= 0
        return true
      
      musics = root_item.musics_attributes.filter( (el) ->
        return el.remove_file != true
      )
      if musics.length > 0
        return false
      else
        return true

    ## VOICE
    $scope.addVoice = (root_item) ->
      # $scope.opus.voices_attributes.push({})
      root_item.voices_attributes.push({})

    $scope.uploadVoice = ($files, $event, $rejected, root_item, $index) ->
      # TODO : spinner
      $upload.upload({
        url: '/api/files',
        file: $files[0]
      }).progress( (evt)  ->
        root_item.voices_attributes[$index].spinner = true
      ).success( (data) ->
        root_item.voices_attributes[$index].local_file = data.path
        root_item.voices_attributes[$index].spinner = false
      )

    $scope.removeVoice = (root_item, $index) ->
      root_item.voices_attributes[$index]._destroy = 1
      root_item.voices_attributes[$index].file.url = null
      root_item.voices_attributes[$index].local_file = null

    $scope.outOfVoice = (root_item) ->
      if !root_item.voices_attributes || root_item.voices_attributes.length <= 0
        return true
      voices = root_item.voices_attributes.filter( (el) ->
        return el.remove_file != true
      )
      if voices.length > 0
        return false
      else
        return true

    ## CHAPTERS
    $scope.uploadChapterCover = ($files, $event, $rejected, $index) ->
      # TODO : spinner
      $upload.upload({
        url: '/api/files',
        file: $files[0]
      }).progress( (evt)  ->
        $scope.opus.chapters_attributes[$index].coverSpinner = true
      ).success( (data) ->
        $scope.opus.chapters_attributes[$index].local_file = data.path
        $scope.opus.chapters_attributes[$index].coverSpinner = false
        $scope.opus.chapters_attributes[$index].remove_background_image = false
      )

    $scope.removeChapterCover = ($index) ->
      $scope.opus.chapters_attributes[$index].remove_background_image = 1
      delete $scope.opus.chapters_attributes[$index].background_image
      delete $scope.opus.chapters_attributes[$index].local_file

    $scope.uploadChapterSlide = ($files, $event, $rejectedFiles, $index) ->
      $upload.upload({
        url: '/api/files',
        file: $files[0]
      }).progress( (evt)  ->
        $scope.opus.chapters_attributes[$index].sliderSpinner = true
      ).success( (data) ->
        if not $scope.opus.chapters_attributes[$index].slider_entries_attributes
          $scope.opus.chapters_attributes[$index].slider_entries_attributes = []
        $scope.opus.chapters_attributes[$index].slider_entries_attributes.push({
          local_file: data.path
        })
        $scope.opus.chapters_attributes[$index].sliderSpinner = false
      )

    $scope.removeChapterSlide = ($chapterIndex, $index) ->
      $scope.opus.chapters_attributes[$chapterIndex].slider_entries_attributes[$index]._destroy = 1
      $scope.opus.chapters_attributes[$chapterIndex].slider_entries_attributes[$index].local_file = null
      $scope.opus.chapters_attributes[$chapterIndex].slider_entries_attributes[$index].url = null


    ## COVER
    $scope.uploadCover = ($files, $event, $rejected) ->
      $upload.upload({
        url: '/api/files',
        file: $files[0]
      }).progress( (evt)  ->
        $scope.opus.coverSpinner = true
      ).success( (data) ->
        $scope.opus.local_file = data.path
        $scope.opus.coverSpinner = false
        $scope.opus.remove_cover = false
      )

    $scope.removeCover = () ->
      $scope.opus.remove_cover = 1
      $scope.opus.cover.url = null
      delete $scope.opus.local_file

    ## COLLABORATIONS
    $scope.users = []
    $scope.refreshUsers = (search) ->
      if search.length > 0
        return $http.post('/api/users/filter', {query: search}).then((response) ->
          $scope.users = response.data
        )
    $scope.updateCollaborationsScope = ($item, $index) ->
      $scope.opus.collaborations_attributes[$index].user_attributes = $item
      $scope.opus.collaborations_attributes[$index].user_id = $item.id
    $scope.removePartner = ($index) ->
      $scope.opus.collaborations_attributes[$index]._destroy = 1
    $scope.addPartner = () ->
      $scope.opus.collaborations_attributes.push({})


    ## KEYWORDS
    $scope.debug = () ->
      console.log $scope.opus

    $scope.removeKeyword = ($index) ->
      $scope.opus.keyword_opuses_attributes[$index]._destroy = 1


    saveKeyword = () ->
      $http.post('/api/keywords/', {label: $scope.newKeyword}).then((response) ->
        keyword = response.data
        keyword.keyword_id = keyword.id
        delete keyword.id
        $scope.opus.keyword_opuses_attributes.push(keyword)
        $scope.newKeyword = ""
        $scope.proposedKeywords = []
      )
        
    $scope.pushKeyword = (existing, keyword) ->
      if existing
        $scope.opus.keyword_opuses_attributes.push(keyword)
      else
        if $scope.proposedKeywords && $scope.proposedKeywords.length > 0
          if $scope.proposedKeywords
            res = $scope.proposedKeywords.filter( (el) ->
              return el.label.toLowerCase() == $scope.newKeyword.toLowerCase()
            )
            if res.length > 0
              res[0].keyword_id = res[0].id
              $scope.opus.keyword_opuses_attributes.push(res[0])
            else
              saveKeyword()
        else
          saveKeyword()

      $scope.newKeyword = ""
      $scope.proposedKeywords = []

    $scope.autocompleteKeyword = () ->
      if $scope.newKeyword && $scope.newKeyword.length > 0
        return $http.post('/api/keywords/filter', {label: $scope.newKeyword}).then((response) ->
          res = []
          if response.data && response.data.keyword_opuses_attributes.length > 0
            if $scope.opus.keyword_opuses_attributes and $scope.opus.keyword_opuses_attributes.length > 0
              # get labels from opus keywords
              keywordsLabels = $scope.opus.keyword_opuses_attributes.map( (el) -> return el.label )
              # remove keywords from autocomplete
              res = response.data.keyword_opuses_attributes.filter( (el) -> 
                return keywordsLabels.indexOf(el.label) <= -1 
              )
          $scope.proposedKeywords = res
        )

    # Steps
    $scope.current = 1
    $scope.nextStep = () ->
      $scope.current = $scope.current + 1

    $scope.previousStep = () ->
      $scope.current = $scope.current - 1
    
    # OPUS
    $scope.saveOpus = () ->
      # open current chapter, show error
      canSave = true

      titleNotEmtpy = !!$scope.opus.title
      if titleNotEmtpy
        $scope.titleRequired = false
      else
        canSave = false
        $scope.titleRequired = true
        $location.hash('title')
        $anchorScroll()

      abstractNotEmtpy = !!$scope.opus.abstract
      if abstractNotEmtpy
        $scope.abstractRequired = false
      else
        canSave = false
        $scope.abstractRequired = true
        $location.hash('abstract')
        $anchorScroll()

      # check price
      priceNotEmpty = !!$scope.opus.price
      if priceNotEmpty
        # check if format is the good one
        regex = /^\d+,\d{2}$/
        if regex.test( $scope.opus.price )
          $scope.badPriceFormat = false
        else
          canSave = false
          $scope.badPriceFormat = true
          $location.hash('price')
          $anchorScroll()

      for chapter, i in $scope.opus.chapters_attributes
        if not chapter.content && not chapter.hasOwnProperty('_destroy')
          canSave = false
          $scope.showChapter(i)
          chapter.error = true

      if canSave
        if $scope.opus.id
          OpusService.put($scope.opus).then( (response) ->
            $window.location.href = '/opuses/' + response.data.id
          )
        else
          OpusService.post($scope.opus).then( (response) ->
            $window.location.href = '/opuses/' + response.data.id
          )

    # TODO previewOpus
    $scope.previewOpus = () ->

    # CHAPTERS
    $scope.currentChapter = 0
    $scope.showChapter = ($index) ->
      $scope.currentChapter = $index
    $scope.addChapter = () ->
      $scope.opus.chapters_attributes.push({
        title: "",
        content: "",
        font_color: "#333333",
        voices_attributes: [],
        musics_attributes: []
      })
      $scope.currentChapter = $scope.opus.chapters_attributes.length - 1
    $scope.removeChapter = ($index) ->
      if $scope.opus.chapters_attributes[$index].hasOwnProperty('id')
        $scope.opus.chapters_attributes[$index]._destroy = 1
      # if it doesn't exist in the database we can safely remove it from the attributes
      else
        $scope.opus.chapters_attributes.splice($index, 1)
      
  )

])

app.factory('OpusService', [ '$http', ($http) ->
  OpusService = {
    get: (opus_id) ->
      $http.get('/opuses/' + opus_id + '.json')
    post: (opus) ->
      $http.post('/opuses/', opus)
    put: (opus) ->
      $http.put('/opuses/' + opus.id, opus)
  }
])

app.directive "clickElsewhere", ($document) ->
  restrict: "A"
  link: (scope, elem, attr, ctrl) ->
    elem.bind "click", (e) ->
      # this part keeps it from firing the click on the document.
      e.stopPropagation()
      return
    $document.bind "click", ->
      # magic here.
      scope.$apply attr.clickElsewhere
      return

    return


app.filter 'classify', () ->
  return (str) ->
    if (str)
      return str.toLowerCase().replace(/\+/g, '-')

