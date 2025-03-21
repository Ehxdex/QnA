require 'rails_helper'

feature 'Authenticated user can delete his answers', %q(
  User must be authenticated,
  move to question page
  Then try to delete some answer.
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, question: question, author: user) }


  scenario 'Authenticated user can delete answer' do
    sign_in(user)
    visit question_path(question)

    # fill_in 'Your Answer', with: "text"
    # click_on 'Submit'

    click_on 'Delete'

    # expect(page).to have_content(answer.body)
    # expect(page).to have_button('Delete')
  end
end
