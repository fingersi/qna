class Question < ApplicationRecord
  
  include Commentable

  belongs_to :author, class_name: 'User'

  has_many :links, as: :linkable
  has_many :answers, dependent: :destroy
  has_one :reward, dependent: :destroy
  has_many_attached :files
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  after_create :subscribe_author

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :reward, reject_if: :all_blank

  validates :title, :body, presence: true

  private

  def subscribe_author
    subscriptions.create!(user: author)
  end
end
