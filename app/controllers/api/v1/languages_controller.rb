module Api::V1
  class LanguagesController < ApplicationController
    def index
      @languages = Language.all
    end
  end
end
