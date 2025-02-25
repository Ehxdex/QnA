require 'rails_helper'

feature 'user can show question', %q(
  passes to the show page
  show current question
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }

  scenario 'show current question' do
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
  end
end
