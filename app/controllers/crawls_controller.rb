class CrawlsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_crawl, only: [:show]

  def crawl_website
    Crawl::CrawlWebsite.call(self, current_user, params)
  end

  def show
  end

  private

  def find_crawl
    @crawl = Crawl.find_by_slug(params[:id])
  end
end
