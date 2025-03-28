require 'rails_helper'

feature 'user can show all questions', %q(
  passes to the index page
  show all questions
) do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, author: user) }

  scenario 'passes to the index page, get all questions' do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end
