require 'rails_helper'

feature 'User can add links to answer', %q(
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
) do
  given(:user) { create(:user) }
  given(:url) { 'https://google.com' }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, question: question, author: user) }

  scenario 'User adds link when give an answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your Answer', with: answer.body

    fill_in 'Link name', with: 'Google'
    fill_in 'Url', with: url

    click_on 'Submit'
    visit question_path(question)


    expect(page).to have_link 'Google', href: url
  end
end
