class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  has_many :questions, foreign_key: :author_id, dependent: :destroy
  has_many :answers, foreign_key: :author_id, dependent: :destroy
  has_many :oauthproviders, class_name: 'OAuthProvider', foreign_key: 'user_id', dependent: :destroy

  validates :email, presence: true
  validates :password, presence: true

  def self.find_for_oauth(auth_data)
    FindForOauth.new(auth_data).call
  end

  def author?(resource)
    id == resource.author_id
  end

  def rewards
    Reward.joins(answer: :author).where(answers: { author_id: self })
  end

end
