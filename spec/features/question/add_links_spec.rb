require 'rails_helper'

feature 'User can add links to question', %q(
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
) do
  given(:user) { create(:user) }
  given(:url) { "https://google.com" }
  given(:question) { create(:question, author: user) }


  scenario 'User adds link when asks question', js: true do
    sign_in(user)
    visit questions_path
    click_on 'New question'

    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body

    fill_in 'Link name', with: 'My link'
    fill_in 'Url', with: url

    click_on 'Create Question'

    expect(page).to have_link 'My link', href: url
  end
end
