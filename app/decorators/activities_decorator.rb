class ActivitiesDecorator < Draper::CollectionDecorator
  def crawled_products_count
    self.map { |activity| activity.crawl.products.length }.sum
  end
end

