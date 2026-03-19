require 'rails_helper'

feature "User can create a answer." do
  given(:user) { create :user }
  given(:question) { create :question }
  given(:answer) { create :answer, question: question}
 

end