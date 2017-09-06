class BackController < ApplicationController
  before_filter :authenticate_admin!
  layout 'back'
end
