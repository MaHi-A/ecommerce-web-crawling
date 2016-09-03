class CrawlsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_crawl, only: [:show, :export_crawl]

  def crawl_website
    Crawl::CrawlWebsite.call(self, current_user, params)
  end

  def show
  end

  def export_crawl
    file, file_type, filename = Exports::Excel::CrawlInfo.generate(@crawl)
    ApplicationMailer.mail_admin(current_user, @crawl).deliver
    send_file file.path, filename: filename, type: file_type, disposition: "attachment"
  end

  private

  def find_crawl
    @crawl = Crawl.find_by_slug(params[:id])
  end
end
