class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = ActivitiesDecorator.decorate(current_user.activities.includes(:crawl).reverse)
  end
end
