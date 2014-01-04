class Reminders < ActionMailer::Base
  default from: "from@les-nuits-de-la-pleine-lune.herokuapp.com"
  def welcome_email(lunatic)
    @lunatic = lunatic
    @url  = 'http://les-nuits-de-la-pleine-lune.herokuapp.com'
    mail(to: @lunatic.email,
         subject: 'The Full Moon is tomorrow',
         template_path: 'reminders',
         template_name: 'email')
  end
end
