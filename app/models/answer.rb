class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  def set_best    
    best_answer = Answer.where("best = true and question_id = #{ question.id }")
    best_answer.each do |ans| 
      ans.best = false
      ans.save!
    end 
    self.best = true
    save!
  end

  def author?(user)
    self.question.author == user
  end
end
