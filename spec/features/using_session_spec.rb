require 'rails_helper'

RSpec.describe 'using_session', js: true do
  it 'sets final_session_name' do
    expect { try_using_session }.to raise_exception RSpec::Expectations::ExpectationNotMetError

    expect(Capybara::Screenshot.final_session_name).to eq :different_session
  end

  it 'uses the methods from capybara-screenshot' do
    expect { try_using_session }.to raise_exception RSpec::Expectations::ExpectationNotMetError

    expect(         method(:using_session).source_location[0]).to match /capybara-screenshot/
    expect(Capybara.method(:using_session).source_location[0]).to match /capybara-screenshot/
  end

  def try_using_session
    visit '/'
    Capybara.using_session(:different_session) do
      visit '/home/other'
      expect(true).to eq false
      # In the screenshot it generates, it should show that we're on "Other", *not* Home
    end
  end
end
