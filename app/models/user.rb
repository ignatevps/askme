class User < ApplicationRecord
  has_secure_password
  has_many :questions

  before_validation :downcase_nickname, :downcase_email

  validates :nickname, presence: true, uniqueness: true, 
                       length: { maximum: 30 }, format: { with: /\A[A-Za-z0-9_]+\z/, 
                       message: 'only allows letters, digits and character _ ' }
  validates :email,    presence: true, uniqueness: true,
                       format: { with: /\A[\w\.]+@([\w-]+\.)+[\w-]{2,4}\z/ }

  def downcase_nickname
    nickname.downcase!
  end
  
  def downcase_email
    email.downcase!
  end
end
