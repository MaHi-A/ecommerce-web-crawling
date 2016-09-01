class CrawlController < ApplicationController

  def crawl_website
    Crawl::CrawlWebsite.call(self, current_user, params)
  end

  def show
  end
end
