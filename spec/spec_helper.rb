ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "shoulda-matchers"

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true

  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

  config.before(:each) do
    Capybara.current_driver = :akephalos if example.metadata[:js]
    Capybara.reset_sessions!

    Mongo.db.collections.each do |collection|
      collection.drop unless collection.name =~ /^system\./
    end
  end

  config.after(:each) do
    Timecop.return
    Capybara.use_default_driver if example.metadata[:js]
  end
end
