namespace :transam_lrs do
  desc "Prepare the dummy app for rspec and capybara"
  task :prepare_rspec => ["app:test:set_test_env", :environment] do
    %w(db:drop db:create db:schema:load db:migrate db:seed).each do |cmd|
      Rails.logger.debug "Running #{cmd} in Core"
      Rails.logger.debug "ENV IS #{Rails.env}"
      Rake::Task[cmd].invoke
    end
  end
end

namespace :test do
  desc "Custom dependency to set test environment"
  task :set_test_env do # Note that we don't load the :environment task dependency
    Rails.env = "test"
  end
end
