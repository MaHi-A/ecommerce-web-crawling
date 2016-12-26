class Crawl::CrawlDecorator

  attr_accessor :url, :products, :document, :user, :controller, :crawl

  def initialize(controller, user, params)
    @products = []
    @user = user
    @url = params[:crawl][:url].strip
    @controller = controller
  end

  def product_list
    document.css('.js-tuple').each { |product| get_product_details(product) }
  end

  def get_product_details(product)
    products.push(
      {
        title: get_product_info(product, '.product-title'),
        actual_price: get_product_info(product, '.strike'),
        offer_price: get_product_info(product, '.product-price'),
        emi: get_product_info(product, '.product-emi'),
        ratings: get_product_info(product, '.product-rating-count'),
        image: get_image_url(product, '.product-tuple-image a img')
      }
    )
  end

  def single_product(product)
    products.push(
      {
        title: get_product_info(product, '.pdp-e-i-head'),
        actual_price: get_product_info(product, '.pdpCutPrice'),
        offer_price: get_product_info(product, '.payBlkBig'),
        offer_percentage: get_product_info(product, '.pdpDiscount'),
        emi: get_product_info(product, '#buyPriceBox .electronics'),
        ratings: get_product_info(product, '.reviewCacheUpdate'),
        reviews: get_product_info(product, '.js-jl-omni'),
        extra_offers: get_product_info(product, '.freebieNotPresentClass'),
        delivery_in: get_product_info(product, '#pdp-pincode-rp p'),
        image: get_image_url(product, '.left-panel-carousel li img')
      }
    )
  end

  def get_image_url(product, css)
    product.at_css(css).attr('src') || product.at_css(css).attr('data-src') if product.at_css(css).present?
  end

  def get_product_info(product, css)
    product.at_css(css).try(:text).to_s.squish
  end

  def store_data
    if products.present?
      @crawl = create_crawl(products)
      create_activity crawl
    end
  end

  def create_crawl(products)
    Crawl.create!(user_id: user.id, url: url, products: products)
  end

  def create_activity(crawl)
    Activity.create!(user_id: user.id, crawl_id: crawl.id)
  end

  def start_crawling
    url.match('^https://www.snapdeal.com/products/') ? product_list : single_product(document)
  end

  def snapdeal_and_valid
    url.match('^https://www.snapdeal.com/') &&
      (url.match('^https://www.snapdeal.com/products/') || url.match('^https://www.snapdeal.com/product/'))
  end

  def open_website
    @document = Nokogiri::HTML(open(url))
  end

  def redirect_with_error_flash
    controller.redirect_to '/dashboard', alert: 'You have to crawl url which starts like https://www.snapdeal.com/products/ or https://www.snapdeal.com/product/'
  end

  def redirect_with_success_flash
    controller.redirect_to "/users/#{user.slug}/crawls/#{crawl.slug}", alert: 'You have successfully crawlled the snapdeal website! Kudos!!'
  end
end
