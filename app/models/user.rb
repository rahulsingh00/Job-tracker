class User < ActiveRecord::Base
  include RFC822
  acts_as_authentic
  
  validates_presence_of :login, :email
  validates_uniqueness_of :login, :email
  validates_format_of :email, :with => EmailAddress

  def activate!
    self.active = true
    self.save!
  end
  
end
