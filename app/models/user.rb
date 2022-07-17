class User < ApplicationRecord
  has_many :articles
  validates :username, presence: true, 
                        uniqueness: { case_sensitive: false }, 
                        length: { minimum: 3, maximum: 25 }
  VALID_REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { maximum: 105 },
                      format: { with: VALID_REGEX_EMAIL }
end
