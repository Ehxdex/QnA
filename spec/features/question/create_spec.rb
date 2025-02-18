require 'rails_helper'

feature 'user can create question', %q(
  passes to the question page
  fills the question form
  presses button create to send new question to the database
) do
  given(:question) { create(:question) }

  scenario 'valid title and body' do
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    click_on 'Ask'

    expect(page).to have_content "Your question successfully created."
  end

  scenario 'empty title and body' do
    visit questions_path
    click_on 'Ask question'
    click_on 'Ask'

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
