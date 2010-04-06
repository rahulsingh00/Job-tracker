class UserObserver < ActiveRecord::Observer
  def after_create(user)
    user.reset_perishable_token!
    activation_url = "http://localhost:3000/activate/#{user.perishable_token}"
    UserMailer.deliver_activation_mail(user,activation_url,"activate account")
  end
end
