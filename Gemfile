source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Simpliest fulltext search
gem 'search_cop'

# used by active storage to create thumbnail
gem 'mini_magick'

gem "image_processing"

# Reads Excel files
gem "roo", "~> 2.7.0"

# Show hashes nicely with ap method
gem "awesome_print"

# Used i.e. by importer to match columns to attributes
gem "fuzzy_match"

# helps with decorators
gem 'draper'

# needed by bootstrap gem
gem 'sprockets-rails'
gem 'bootstrap'

# will be initialized with bootstrap support
gem 'simple_form', '~> 4.0'

# creates multistep forms for models
gem 'wicked'

# Used for rails 5.2 for faster application start
gem 'bootsnap', require: false

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'

# Use Puma as the app server
gem 'puma', '~> 3.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# postgres
gem 'pg'

# batch import
gem 'activerecord-import'

# makes credential in config/application.yml available for rail (added to .gitignore)
gem "figaro"

# Gives sorted models
gem 'acts_as_list'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem "factory_bot_rails"
	gem 'rspec-rails'
	gem 'guard'
	gem 'guard-rspec'
  gem 'capybara' # for feature tests
  gem "capybara-webkit"
#  gem 'selenium-webdriver' # have capybara know about ajax calls
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "rails-erd" # Generate Entity-Relationship Diagrams
  gem 'capistrano'
  gem 'capistrano-bundler' # for bundle install task
  gem 'capistrano-rails' # migrate and compile asset tasks
  gem 'capistrano3-puma' # puma tasks
  gem 'scout_apm' # used for profiling
  gem 'rack-mini-profiler' # also profiling
  gem 'memory_profiler' # For memory profiling used by rack-mini-profiler
  # For call-stack profiling flamegraphs used by rack-mini-profiler
  gem 'flamegraph'
  gem 'stackprof'
	gem 'ruby-prof'
end
