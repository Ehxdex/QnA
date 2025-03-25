require 'rails_helper'

feature 'Authenticated user can edit answers', %q(
  To edit answer
  the user must authenticate
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, question: question, author: user) }

  scenario 'Authenticated user edit answer' do
    sign_in(user)
    visit edit_answer_path(answer)

    fill_in 'Your Answer', with: "text", fill_options: { clear: :none }
    click_on 'Submit'

    expect(page).to have_content answer.body
  end
end
