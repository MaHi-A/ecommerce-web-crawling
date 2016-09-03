require "axlsx"
require "exports/excel/report_styler"

module Exports
  module Excel
    class CrawlInfo
      attr_accessor :sheet
      attr_reader :styler, :products, :crawl

      def initialize(crawl)
        @crawl = crawl
        @products = crawl.products
      end

      def self.generate(products)
        Exports::Excel::CrawlInfo.new(products).generate
      end

      def generate
        Axlsx::Package.new do |p|
          p.workbook do |wb|
            wb.styles do |style_obj|
              @styler = Exports::Excel::ReportStyler.new(style_obj)
              p.workbook.add_worksheet do |sheet|
                self.sheet = sheet
                title
                sub_title
                table_generator
              end
            end
          end

          file_name = get_file_name
          file = get_file file_name
          p.serialize file.path
          return file, "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet", file_name
        end
      end

      # Report Title Styles
      def title
        sheet.add_row ['Crawl Information', nil, nil, nil, nil], height: 40, style: styler.report_styles(24)
      end

      def get_file_name
        "Crawl_information_#{crawl.id}.xlsx"
      end

      def sub_title(merge_cells = ["A1:C1", "A2:C2"])
        sheet.add_row ["List of Products Crawled", nil, nil, nil, nil], style: styler.report_styles(12)
        merge_cells.each { |cells| sheet.merge_cells(cells) }
      end

      def table_generator
        excel_header
        write_products
      end

      def write_products
        products.each_with_index do |product, index|
          sheet.add_row product_details(product, index), style: styler.table_row
        end
      end

      def product_details(product, index)
        product.values.unshift(index + 1)
      end

      def excel_header
        sheet.add_row products.first.keys.map(&:capitalize).unshift('S No'), style: styler.table_header
      end

      def get_file(file_name)
        Tempfile.new(file_name, "#{Rails.root}/tmp")
      end
    end
  end
end
