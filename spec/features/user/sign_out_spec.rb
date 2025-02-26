require 'rails_helper'

feature 'User can sign out', %q(
  If user is logged in
  user can log out from the system
) do
  given(:user) { create(:user) }

  scenario 'User tries to log out' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content "Signed in successfully."

    click_on 'Logout'

    expect(page).to have_content "Signed out successfully."
  end
end
