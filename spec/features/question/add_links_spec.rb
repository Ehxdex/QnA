require 'rails_helper'

feature 'User can add links to question', %q(
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
) do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/Ehxdex' }
  given(:question) { create(:question, author: user) }


  scenario 'User adds link when asks question' do
    sign_in(user)
    visit questions_path
    click_on 'New question'

    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Create Question'

    click_on question.title

    expect(page).to have_link 'My gist', href: gist_url
  end
end
