class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  def set_best    
    best_answers = question.answers.where(best:true)    
    Answer.transaction do
      best_answers.each do |ans| 
        ans.best = false
        ans.save!
      end 
      self.best = true
      save!
    end
  end

  def author?(user)
    question.author_id = user.id
  end
end
