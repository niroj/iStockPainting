class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to painting_path(8)
    end
  end
end
