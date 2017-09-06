app.factory('MusicService', [ '$q', ($q) ->
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

