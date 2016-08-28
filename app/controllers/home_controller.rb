class HomeController < ApplicationController
  def show
    user_signed_in? ? dashboard_path : root_path
  end
end
