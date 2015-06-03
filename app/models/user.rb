class User < ActiveRecord::Base

  has_secure_password

  has_many :recipes

  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false}

  validates :password_digest,
    presence: true,
    :on => :create

  validates :name, presence: true

  def self.authenticate email, password_digest

    User.find_by_email(email).try(:authenticate, password_digest)

  end


end
