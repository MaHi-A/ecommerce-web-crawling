class ActivitiesController < ApplicationController

  def index
    @activities = current_user.activities.includes(:crawl).reverse
  end
end
