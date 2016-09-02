class ActivitiesController < ApplicationController

  def index
    @activities = ActivitiesDecorator.decorate(current_user.activities.includes(:crawl).reverse)
  end
end
