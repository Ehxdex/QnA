require 'rails_helper'

feature 'User can edit his question', %q(
  In order to correct mistakes
  As an author of question
  I'd like to be able to edit my question
) do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:question2) { create(:question, author: user2) }

  scenario 'Unauthenticated can not edit question' do
    visit questions_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    scenario 'edits his question' do
      sign_in(user)
      visit question_path(question)

      click_on 'Edit'

      fill_in 'Body', with: 'some text'
      click_on 'Update Question'

      expect(page).to_not have_content question.body
      expect(page).to_not have_content 'edited answer'
    end

    scenario "tries to edit other user's question" do
      sign_in(user2)
      visit question_path(question)

      expect(page).to_not have_content('Edit')
    end
  end
end
