module Api::V1
  class AtmospheresController < ApplicationController
    def index
      @atmospheres = Atmosphere.all
    end
  end
end
