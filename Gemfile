source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 3.2.15'

gem 'slim'
gem 'flickr_fu', github: 'commonthread/flickr_fu'
gem 'fog'
gem 'jquery-rails'

group :production do
  gem 'rails_12factor'
  gem 'thin'
  gem 'dalli'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :test do
  gem 'timecop'
end

group :tools do
  gem 'heroku'
  gem 'foreman'
  gem 'powder'

  # Guard
  gem 'ruby_gntp'
  gem 'guard-pow'
  gem 'guard-rspec'
end
