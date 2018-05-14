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

# read env variables from serverfile as puma doesnt load env variables itself
# we switch to canonical config file secrets.yml
#gem 'dotenv-rails', :require => 'dotenv/rails-now'

# bootstrap 3 for use with simple_form
# now using bootstrap 4 as simple_form 4 supports it now
#gem 'bootstrap-sass'

# helps with decorators
gem 'draper'

# needed by bootstrap gem
gem 'sprockets-rails'
gem 'bootstrap'

# will be initialized with bootstrap support
gem 'simple_form', '~> 4.0', git: 'git://github.com/plataformatec/simple_form.git'

# creates multistep forms for models
gem 'wicked'

# creates simple and nice nested forms
gem 'cocoon'

# Used for rails 5.2 for faster application start
gem 'bootsnap', require: false

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# postgres
gem 'pg'

# batch import
gem 'activerecord-import'

# makes credential in config/application.yml available for rail (added to .gitignore)
gem "figaro"

gem 'acts_as_list'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end
  # ToDo: MOVE to dev group
 gem 'listen', '~> 3.0.5'

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
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use of rails_admin for more technical administrations
gem 'rails_admin', '~> 1.3'
gem "rails_admin_simple_has_many" # Alternative widget to select has_many
