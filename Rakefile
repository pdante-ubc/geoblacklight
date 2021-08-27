# encoding: UTF-8
# frozen_string_literal: true
require 'rails'
begin
  require 'bundler/setup'
  require 'bundler/gem_tasks'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'engine_cart/rake_task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run RuboCop style checker'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.requires << 'rubocop-rspec'
  task.fail_on_error = true
end

task(:spec).clear
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end

desc 'Run JavaScript unit tests'
task :javascript_tests do
  system '/bin/bash -c yarn test'
end

desc 'Run test suite'
task ci: ['geoblacklight:generate'] do
  within_test_app do
    system 'RAILS_ENV=test rake geoblacklight:index:seed'
    system 'RAILS_ENV=test bundle exec rails webpacker:compile'
  end

  # Run RSpec tests with Coverage
  Rake::Task['geoblacklight:coverage'].invoke

  # Run JavaScript tests
  Rake::Task['javascript_tests'].invoke
end

namespace :geoblacklight do
  desc 'Run tests with coverage'
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task['spec'].invoke
  end

  desc 'Create the test rails app'
  task generate: ['engine_cart:generate'] do
    # Intentionally Empty Block
  end

  namespace :internal do
    task :seed do
      within_test_app do
        system 'bundle exec rake geoblacklight:solr:seed'
        system 'bundle exec rake geoblacklight:solr:seed RAILS_ENV=test'
        system 'bundle exec rake geoblacklight:downloads:mkdir'
      end
    end
  end

  desc 'Stdout output asset paths'
  task :asset_paths do
    within_test_app do
      system 'bundle exec rake geoblacklight:application_asset_paths'
    end
  end
end

namespace :server do
  desc 'Run GeoBlacklight for interactive development'
  task :start, [:rails_server_args] do |_t, args|
    if File.exist? EngineCart.destination
      within_test_app do
        system 'bundle update'
      end
    else
      Rake::Task['engine_cart:generate'].invoke
    end

    within_test_app do
      begin
        system "bundle exec rails s #{args[:rails_server_args]}"
      rescue Interrupt
        puts 'Shutting down...'
      end
    end
  end
end

namespace :solr do
  desc 'Run Solr and seed with sample data'
  task :start do
    if File.exist? EngineCart.destination
      within_test_app do
        system 'bundle update'
      end
    else
      Rake::Task['engine_cart:generate'].invoke
    end

    system('lando start')
    Rake::Task['geoblacklight:internal:seed'].invoke
  end

  desc 'Stop Solr'
  task :stop do
    system('lando stop')
  end
end

task default: [:ci]
