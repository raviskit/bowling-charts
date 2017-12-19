require 'spec_helper'

feature 'Bowling workflows', js: false do
  background do
    visit('/bowling')
  end

  feature 'shows form with form containing try1 and try2 ' do
    scenario 'page contains form' do
      expect(page).to have_content('Enter the Pins knocked:')
      expect(page).to have_content('Try1 Try2')
      expect(page).to have_xpath("//form[@action='/bowling/frame']")
    end

    scenario 'page contains new game link' do
      page.find_button('Submit Frame').click
      expect(page).to have_link('New Game')
    end

    scenario 'page contains results table' do
      page.find_button('Submit Frame').click
      expect(page).to have_xpath("//table[@id='results']")
    end
  end
end