require 'rails_helper'

feature 'User can create question', %q(
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'New question'
    end

    scenario 'asks a question' do
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      click_on 'Create Question'

      expect(page).to have_content "Your question successfully created."
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end

    scenario 'asks a question with errors' do
      click_on 'Create Question'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
    end

    scenario 'asks a question with attached file' do
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      attach_file 'File', [ "#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb" ]

      click_on 'Create Question'

      expect(page).to have_content "rails_helper.rb"
      expect(page).to have_content "spec_helper.rb"
    end
  end

  scenario 'Unauthenticated user tries to ask a question' do
    visit questions_path
    click_on 'New question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
