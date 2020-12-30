source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'pg', '>= 0.18', '< 2.0' #database
gem 'puma', '~> 4.1' #server
gem 'jbuilder', '~> 2.7' #json rendering
gem 'redis', '~> 4.0' #websockets
gem 'bcrypt', '~> 3.1.7' #encryption
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors' # cors
gem 'devise_token_auth' # authentication
gem 'pg_search' # full textsearch
gem 'pundit' # authorization
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  %w[rspec-core rspec-rails rspec-expectations rspec-mocks rspec-support].each do |lib|
    gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
  end
end
group :test do
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'database_cleaner'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
