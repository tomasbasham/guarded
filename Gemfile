source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers', '~> 0.10.6'
gem 'bcrypt',                   '~> 3.1.7'
gem 'guardsman',                '~> 0.0.3'
gem 'kaminari',                 '~> 1.1.1'
gem 'rails',                    '~> 5.1.4'
gem 'pg',                       '~> 0.18'
gem 'puma',                     '~> 3.7'
gem 'pundit',                   '~> 1.1.0'
gem 'rack-cors',                '~> 1.0.1'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails',            '~> 3.7.1'
end

group :development do
  gem 'listen',                 '>= 3.0.5', '< 3.2'
  gem 'spring',                 '~> 2.0.2'
  gem 'spring-watcher-listen',  '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
