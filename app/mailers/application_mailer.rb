class ApplicationMailer < ActionMailer::Base
  default from: 'anethala.geek@gmail.com'
  layout 'mailer'

  def mail_admin(user,crawl)
    @user = user
    @crawl = crawl
    mail(to: "anethalamahesh@gmail.com", subject: "#{user.first_name} has downloaded the crawl! Check it out!!")
  end
end
