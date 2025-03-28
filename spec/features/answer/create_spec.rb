require 'rails_helper'

feature 'Authenticated user can create answers', %q(
  To answer the question
  the user must authenticate
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, question: question, author: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end
    scenario 'create answer' do
      fill_in 'Your Answer', with: answer.body
      click_on 'Submit'

      expect(page).to have_content 'Answer successfully created'
      expect(current_path).to eq question_answers_path(question)

      expect(page).to have_content answer.body
    end


    scenario 'create answer with error' do
      click_on 'Submit'

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'create answer with attached file' do
      fill_in 'Your Answer', with: answer.body
      attach_file 'File', [ "#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb" ]

      click_on 'Submit'

      expect(page).to have_content "rails_helper.rb"
      expect(page).to have_content "spec_helper.rb"
    end
  end


  scenario 'Unauthenticated user tries to create answer' do
    visit question_path(question)

    fill_in 'Your Answer', with: answer.body
    click_on 'Submit'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
