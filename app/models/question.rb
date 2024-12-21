class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true

  def answers
    Answer.where(question_id: self.id).order(best: :desc)
  end
end
