require 'rails_helper'

feature 'User can sign in', %q(
  In order to log in to the system
  user must go through
  the registration procedure
) do
  given(:user) { build(:user) }

  background { visit new_user_registration_path }

  scenario 'User tries to sign up' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation

    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
