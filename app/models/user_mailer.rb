class UserMailer < ActionMailer::Base

  def activation_mail(user,activation_url,type)
    @recipients = user.email
    @from = 'sumanmukherjee03@gmail.com'
    if type == "activate_account"
      @subject = "Activate your account"
    elsif type == "forgot password"
      @subject = "Retrieve your password"
    end
    @body = {:user => user, :activation_url => activation_url, :type => type}
    @content_type = 'text/html'
  end

end
