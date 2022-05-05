class Usuario < ApplicationRecord
  before_save { self.email = email.downcase }
  before_save { self.password = BCrypt::Password.create(password) }
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  }
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  def validar_password
    BCrypt::Password.new(self.password)
  end
end
