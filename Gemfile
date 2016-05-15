source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'

# Use Puma as the app server
gem 'puma', '~> 3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making
# cross-origin AJAX possible.
# gem 'rack-cors'

group :development, :test do
  gem 'byebug',             platform: :mri
  gem 'factory_girl_rails'
  gem 'flay',               require: false
  gem 'flog',               require: false
  gem 'rspec-rails'
  gem 'rubocop',            require: false
  gem 'simplecov',          require: false
end

group :development do
  # Better errors handler
  gem 'better_errors', '~> 1.0.1'
  gem 'binding_of_caller', '~> 0.7.2'

  # Help to kill N+1 queries and unused eager loading
  gem 'bullet', require: false

  gem 'listen'

  gem 'overcommit'

  # Line-profiler for ruby
  gem 'rblineprof', platform: :mri, require: false

  # Rails Console on the Browser.
  gem 'web-console', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# gem 'rspec-retry'
