require 'spec_helper'

feature 'User Registration' do
  scenario 'User can create an account and a welcome email is sent' do
    visit '/'

    expect(ActionMailer::Base.deliveries.length).to eq 0

    click_link 'Register'

    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Register'

    expect(page).to have_content 'Welcome, user@example.com'
    expect(page).to_not have_link 'Add Publisher'
    expect(ActionMailer::Base.deliveries.length).to eq 1
  end

  scenario 'Users see an error message if they register with an invalid email' do
    visit '/'

    click_link 'Register'

    fill_in 'user[email]', with: 'invaliduser@example,com'
    fill_in 'user[password]', with: 'password'
    click_on 'Register'

    expect(current_path).to eq '/users/new'
    expect(page).to have_content 'invalid email/password'
  end
end
