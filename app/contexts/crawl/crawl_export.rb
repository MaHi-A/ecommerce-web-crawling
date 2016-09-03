class Crawl::CrawlExport
  attr_reader :crawl

  def initialize(crawl)
    @crawl = crawl
  end

  def self.call(crawl)
    new(crawl).call
  end

  def call
    Exports::Excel::CrawlInfo.new(crawl).generate
  end
end
