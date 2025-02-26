require 'rails_helper'

feature 'user can show answers', %q(
  passes to the question show page
  show answers
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answers) { create_list(:answer, 3, question: question, author: user) }

  scenario 'show answers' do
    visit question_path(question)

    answers.each do |answer|
      expect(page).to have_content(answer.body)
    end
  end
end
