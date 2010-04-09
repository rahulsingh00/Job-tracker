class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_activation_mail(user,"activate_account")
  end
end
