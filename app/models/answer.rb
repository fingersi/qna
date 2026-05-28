class Answer < ApplicationRecord

  include Votable
  include Commentable

  belongs_to :question, touch: true
  belongs_to :author, class_name: 'User'

  has_many :links, as: :linkable
  has_many_attached :files

  after_create :notify_subscribers

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true

  def set_best
    question.answers.where(best: true).update_all(best: false)
    update!(best: true)
    question.reward.update!(answer: self) if question.reward.present?
  end

  private

  def notify_subscribers
    AnswerNotificationJob.perform_later(self)
  end
end
