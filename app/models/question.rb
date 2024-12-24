class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true

  def answers_sort_by_best
    answers.order(best: :desc)
  end
end
