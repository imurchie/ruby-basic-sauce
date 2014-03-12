require 'rubygems'
require "test/unit"
require 'selenium-webdriver'

class ExampleTest < Test::Unit::TestCase
    def setup
        caps = Selenium::WebDriver::Remote::Capabilities.firefox
        caps.version = "5"
        caps.platform = :XP
        caps[:name] = "Testing Selenium 2 with Ruby on Sauce"
        caps["max-duration"] = 1

        username   = ENV['SAUCE_USERNAME']
        access_key = ENV['SAUCE_ACCESS_KEY']

        @driver = Selenium::WebDriver.for(
          :remote,
          :url => "http://#{username}:#{access_key}@ondemand.saucelabs.com:80/wd/hub",
          :desired_capabilities => caps)
    end

    def test_sauce
        @driver.navigate.to "http://saucelabs.com/test/guinea-pig"
        sleep(30)
        assert @driver.title.include?("I am a page title - Sauce Labs")
    end

    def teardown
        @driver.quit
    end
end
