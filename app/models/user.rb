class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: {maximum: Setting.user.email_length},
  format: {with: VALID_EMAIL_REGEX}, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Setting.user.password_length}
  validates :name, presence: true, length: {maximum: Setting.user.name_length}
  before_save{email.downcase!}
  has_secure_password
end
