require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  
  # SETUP
  before :each do
    @user = User.create!(
      first_name: 'David',
      last_name: 'Lynch',
      email: 'eraserhead@radiator.com',
      password: 'twinpeaks',
      password_confirmation: 'twinpeaks'
    )
  end

  scenario "They are taken to home page after successful login" do

    visit root_path
    click_link 'Log In'

    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password

    click_button 'Submit'

    save_screenshot

    expect(page).to have_link 'Log Out', href: '/logout'
    expect(page).to have_content @user.first_name

  end

end
