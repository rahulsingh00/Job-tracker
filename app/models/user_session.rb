class UserSession < Authlogic::Session::Base
  
  validate :active_or_not?
  
  def active_or_not?
    errors.add(:base, "You have not yet activated your account") unless attempted_record && attempted_record.active
  end

end
