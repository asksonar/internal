ruby "2.2.3"

source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
# gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# use postgres instead of sqlite3
gem 'pg'
# user login framework
gem 'devise'
# add invitation support for devise
gem 'devise_invitable'
# bootstrap_form_for helper
gem 'bootstrap_form'
# navbar_item helper
# gem 'rails_bootstrap_navbar'
# used in ActiveRecordHashids for obfuscating ids
gem 'hashids'
# user authorization framework
gem 'pundit'
# better server than webrick
gem 'thin'
# sanitizer for non-markup
gem 'sanitize'
# gives us local_time and local_time_ago to handle timezones via javascript
gem 'local_time'
# pagination gem, with bootstrap styling
gem 'kaminari-bootstrap'

source 'https://rails-assets.org' do
  # bootstrap with sass variables
  gem 'rails-assets-bootstrap-sass'
  # more icon elements than bootstrap has
  gem 'rails-assets-fontawesome', '4.3.0' # verison 4.4.0 uses /fonts instead of /assets, which breaks
  # handlebars javascript templating library
  gem 'rails-assets-handlebars'
  # lets us copy to clipboard
  gem 'rails-assets-zeroclipboard'
  # gives us nice-looking error messages, configured in application.html.erb
  gem 'rails-assets-remarkable-bootstrap-notify'
  # add animations for notify
  gem 'rails-assets-animate.css'
  # add helper to manipulate URLs
  gem 'rails-assets-URIjs'
  # add jqueryui for animate controls
  gem 'rails-assets-jqueryui'
  # add modulejs so we don't need to reorder javascript files
  gem 'rails-assets-modulejs'
  # much nicer looking selects by turning them into button dropdowns
  gem 'rails-assets-bootstrap-select'
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
