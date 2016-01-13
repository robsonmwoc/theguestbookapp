require 'rails_helper'

RSpec.feature 'Guestbook', type: :feature do
  scenario 'User creates a new entry' do
    visit '/'

    fill_in 'Name', with: 'My Name'
    fill_in 'Message', with: 'Hello there!'
    click_button 'Add message'

    expect(page).to have_text('Message was added successfully')
  end

  scenario "User doesn't provide all required information" do
    visit '/'

    fill_in 'Name', with: 'My Name'
    click_button 'Add message'

    expect(page).to have_text("can't be blank")
  end

  scenario 'User read entries' do
    create(:entry)

    visit '/'

    expect(page).to have_text('Conan')
    expect(page).to have_text('First!')
    expect(page).to have_text('less than a minute')
  end

  scenario 'User removes an entry' do
    entry = create(:entry)

    visit '/'

    within("#entry_#{entry.id}") do
      click_link 'Delete'
    end

    expect(page).to_not have_text('Conan')
  end
end
