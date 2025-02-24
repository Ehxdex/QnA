require 'rails_helper'

feature 'User can sign out', %q(
  If user is logged in
  user can log out from the system
) do
  given(:user) { create(:user) }

  scenario 'User tries to log out' do
    visit questions_path

    click_on 'Logout'

    expect(page).to have_content "Signed out successfully."
  end
end
