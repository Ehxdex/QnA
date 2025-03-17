require 'rails_helper'

feature 'Authenticated user can create answers', %q(
  To answer the question
  the user must authenticate
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, question: question, author: user) }

  scenario 'Authenticated user create answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your Answer', with: answer.body
    click_on 'Post Your Answer'

    expect(page).to have_content 'Answer successfully created'
    expect(current_path).to eq question_answers_path(question)

    expect(page).to have_content answer.body
  end

  scenario 'Unauthenticated user tries to create answer' do
    visit question_path(question)

    fill_in 'Your Answer', with: answer.body
    click_on 'Post Your Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user create answer with error' do
    sign_in(user)
    visit question_path(question)

    click_on 'Post Your Answer'

    expect(page).to have_content "Body can't be blank"
  end
end
