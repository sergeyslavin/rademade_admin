# -*- encoding : utf-8 -*-
require 'simplecov'
require 'coveralls'
require 'minitest/autorun' 

SimpleCov.start('rails') do
  adapters.delete(:root_filter)
  filters.clear
  add_filter do |src|
    !(src.filename =~ /^#{SimpleCov.root}/) unless src.filename =~ /rademade_admin/
  end
  add_filter 'spec'

  add_group 'Controllers', 'app/controllers/rademade_admin'
  add_group 'Helpers',     'app/helpers/rademade_admin'
  add_group 'Inputs',      'app/inputs/rademade_admin'
  add_group 'Models',      'app/models/rademade_admin'
  add_group 'Serializers', 'app/serializers/rademade_admin'
  add_group 'Services',    'app/services/rademade_admin'
  add_group 'Views',       'app/views/rademade_admin'
  add_group 'Libraries',   'lib/rademade_admin'
end

require File.expand_path('../../spec/dummy/config/environment', __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-webkit'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'database_cleaner'
require 'factory_girl_rails'

FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
FactoryGirl.reload

Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 10
Capybara.automatic_reload = false

Capybara::Screenshot.autosave_on_failure = false

Coveralls.wear!

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause this
# file to always be loaded, without a need to explicitly require it in any files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, make a
# separate helper file that requires this one and then use it only in the specs
# that actually need it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  config.include Capybara::DSL
  config.include Rails.application.routes.url_helpers
  # for controllers testing
  config.include RSpec::Rails::ControllerExampleGroup
  config.infer_base_class_for_anonymous_controllers = false
  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.

  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.include FactoryGirl::Syntax::Methods

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  #config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
    expectations.syntax = :expect
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    mocks.syntax = :expect

    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended.
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = 'mongoid'
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

end
