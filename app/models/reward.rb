class Reward < ApplicationRecord
  belongs_to :question
  belongs_to :answer, optional: true

  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true

  def author
    question.author
  end

  def winner
    answer&.author
  end
end
