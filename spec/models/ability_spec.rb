require 'rails_helper'

RSpec.describe Ability, type: :model  do

  subject(:abibilty) { Ability.new(user) }

  describe 'guest' do 
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }

    it { should_not be_able_to :manage, :all}
  end

  describe 'admin' do 
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all}
  end

  describe 'user' do
    let(:user) { create :user, admin: false }

    it { should_not be_able_to :manage, :all}
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Question }
    it { should be_able_to :create, Link }

    it { should be_able_to :update, create(:question, author: user) }
    it { should_not be_able_to :update, create(:question) }

    it { should be_able_to :update, create(:answer, author: user), user: user }
    it { should_not be_able_to :update, create(:answer), user: user }

    it { should be_able_to :destroy, create(:answer, author: user) }
    it { should be_able_to :destroy, create(:link, :with_answer_author, author: user)}

    it { should be_able_to :destroy, ActiveStorage::Attachment }
  end

end