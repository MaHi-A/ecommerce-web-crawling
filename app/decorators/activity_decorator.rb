class ActivityDecorator < Draper::Decorator
  delegate_all
  decorates_association :crawl

  def formatted_time(date)
    date.localtime.strftime('%F %I:%M %p')
  end
end
