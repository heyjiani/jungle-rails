class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, :password_confirmation, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email(email.strip.downcase)

    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
