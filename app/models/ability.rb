class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    
    alias_action :get, to: :read

    if user
      user.admin? ? admin_ability : user_ability
    else
      guest_ability
    end
  end

  def admin_ability
    can :manage, :all
  end

  def user_ability
    guest_ability
    cannot :destroy, Question
    can :create, [Question, Answer, Link, Subscription, Comment]
    can :update, [Question, Answer, Link], author: user
    can :destroy, Answer, author: user
    can :destroy, Link do |link| 
      link.linkable.author_id == user.id
    end
    can :set_best, Answer do |answer|
      answer.question.author.id == user.id
    end
    can :vote, Answer do |answer|
      answer.author.id != user.id
    end
    can :destroy, ActiveStorage::Attachment do |file| 
      file.record.author.id == user.id
    end
    can :like, Answer do |answer|
      answer.author.id != user.id
    end
    can :profile, :all
    cannot :other_user, :all
    can :destroy, Subscription, user: user
  end

  def guest_ability
    cannot :profile, :all
    can :read, :all
  end
end
