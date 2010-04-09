class UserMailer < ActionMailer::Base

  def activation_mail(user,type)
    user.reset_perishable_token!
    @recipients = user.email
    @from = 'sumanmukherjee03@gmail.com'
    if type == "activate_account"
      @subject = "Activate your account"
    elsif type == "forgot password"
      @subject = "Retrieve your password"
    end
    @body = {:user => user, :type => type}
    @content_type = 'text/html'
  end

end
