class PagesController < ApplicationController
  def main
    redirect_to "/home" if current_user
  end

  def home
  end
end
