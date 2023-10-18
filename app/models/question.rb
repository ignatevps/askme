class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  validates :body, presence: true
  validates :body, length: { maximum: 255, message: "maximum 255 character" }
end
