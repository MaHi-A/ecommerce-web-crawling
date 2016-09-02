class DashboardController < ApplicationController
  def show
    @crawl = Crawl.new
    @activities = ActivitiesDecorator.decorate(current_user.activities.includes(:crawl).last(30).reverse)
  end
end
