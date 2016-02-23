class Question < ActiveRecord::Base
  validates :title, :description, presence: true

  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
end
