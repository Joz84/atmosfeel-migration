module Api::V1
  class AuthorsController < ApplicationController
    def index
      if params[:id].present?
        @opus = Opus.find(params[:id])
        @authors = @opus.collaborators
        # not the same datas as regular index
        render :search_index
      else
        # pas encore de recherche
        @authors = User.artist
      end
    end

    def show
      @author = User.artist.find(params[:id])
    end

    private
    # a utiliser pour la recherche sur l'index
    def author_params
      params.permit(:order_attr, :order_val, :page)
    end
  end
end
