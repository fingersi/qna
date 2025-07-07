class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  has_many_attached :files

  validates :body, presence: true

  def set_best  
      question.answers.where(best:true).update_all(best: false)
      self.best = true
      save!
  end
end
