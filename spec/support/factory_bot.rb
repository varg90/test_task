RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  Dir[Rails.root.join('../../spec/factories/*.rb')].each { |f| require f }
end
