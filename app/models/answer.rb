class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  has_many_attached :files

  validates :body, presence: true

  def set_best  
    Answer.transaction do
      question.answers.where(best:true).find_each(batch_size: 100) do |ans| 
        ans.best = false
        ans.save!
      end 
      self.best = true
      save!
    end
  end
end
