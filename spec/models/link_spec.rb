require 'rails_helper'

RSpec.describe Link, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of :url }
  it { should validate_presence_of :title }
end
