class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  has_many :links, as: :linkable
  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true

  def set_best  
    question.answers.where(best:true).update_all(best: false)
    self.best = true
    save!
  end
end
