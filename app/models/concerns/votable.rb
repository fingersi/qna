module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy
  end

  def author?(user)
    author == user
  end

  def same_decision?(user, decision)
    votes.exists?(user: user, value: decision)
  end

  def clear_vote(user)
    votes.where(user: user).destroy_all
  end

  def view_votes(user = nil)
    votes.where(value: true).count - votes.where(value: false).count
  end

end