class ActivitiesDecorator < Draper::CollectionDecorator
  def crawled_products_count
    self.each { |activity, sum| sum + activity.crawl.products.length }

    # <%= @activities.crawled_products_count %>
  end
end
