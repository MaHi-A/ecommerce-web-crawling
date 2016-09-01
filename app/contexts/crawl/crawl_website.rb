class Crawl::CrawlWebsite

  attr_accessor :decorator

  def self.call(controller, user, params)
    new(controller, user, params).call
  end

  def initialize(controller, user, params)
    @decorator = Crawl::CrawlDecorator.new(controller, user, params)
  end

  def call
    if decorator.snapdeal_and_valid
      decorator.open_website
      decorator.start_crawling
      decorator.store_data
      decorator.redirect_with_success_flash
    else
      decorator.redirect_with_error_flash
    end
  end
end


