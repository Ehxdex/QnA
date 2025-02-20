require 'rails_helper'

feature 'user can create answers', %q(
  passes to the question path
  create new answer
) do
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }

  scenario 'create answers' do
    visit question_path(question)

    fill_in 'Your Answer', with: answer.body
    click_on 'Post Your Answer'
  end
end
