class Exports::Excel::ReportStyler

  attr_reader :style

  def initialize(excel_style)
    @style = excel_style
  end

  # Export Module Generic Styles
  def report_styles(size = 12)
    @org_name_style ||= style.add_style b: true,
                                        sz: size,
                                        alignment: { horizontal: :left, wrap_text: true }
  end

  def table_header
    @table_header_style ||= style.add_style fg_color: "FF2A00",
                                            alignment: { horizontal: :left , wrap_text: true }
  end

  def table_row
    @table_row_style ||= style.add_style alignment: { horizontal: :left , wrap_text: true }
  end
end
