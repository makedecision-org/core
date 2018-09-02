source 'https://rubygems.org'

gem 'rake'

# http layer
gem 'hanami',       '1.2.0'
gem 'puma', '~> 3.11.0'

# persistance layer
gem 'hanami-model', '~> 1.2'
gem 'pg'

# dependency managment
gem 'dry-system', '~> 0.9.0'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'

# business logic section
gem 'dry-monads', '~> 1.0.0'

# templates
gem 'slim'
gem 'sass'
gem 'hanami-bootstrap'
gem 'jquery-hanami'

# markdown
gem 'kramdown', '1.13.1'
gem 'rouge', '1.11.1'
gem 'rinku'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'

  gem 'database_cleaner'
  gem 'hanami-fabrication'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'rspec-hanami'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

group :production do
  # gem 'puma'
end
