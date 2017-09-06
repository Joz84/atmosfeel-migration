module Api::V1
  class PlayTimesController < ApplicationController
    def index
      @play_times = PlayTime.all
    end
  end
end
