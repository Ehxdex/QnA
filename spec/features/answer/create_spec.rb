require 'rails_helper'

feature 'Authenticated user can create answers', %q(
  To answer the question
  the user must authenticate
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, question: question, author: user) }

  scenario 'Authenticated user create answer' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit question_path(question)

    fill_in 'Your Answer', with: answer.body
    click_on 'Post Your Answer'

    visit question_path(question)

    expect(page).to have_content 'Answer successfully created'
    expect(page).to have_content answer.body
  end

  scenario 'Unauthenticated user tries to create answer' do
    visit question_path(question)

    fill_in 'Your Answer', with: answer.body
    click_on 'Post Your Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user create answer with error' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit question_path(question)

    click_on 'Post Your Answer'

    expect(page).to have_content "Body can't be blank"
  end
end
