
class Browser
  include DateHelper
  include DirectoryHelper

  attr_reader :driver, :browser_name, :x_position, :y_position, :screen_width, :screen_height, :log

  def initialize(browser_name, x_position, yPosition, screen_width, screen_height)
    @browser_name    = browser_name
    @log             = Logger.new(DirectoryHelper.create_log_directory + browser_name + '-' + DateHelper.set_log_timestamp, 'daily')
    @driver          = start_browser(@browser_name)
    @x_position      = x_position
    @y_position      = y_position
    @screen_width    = screen_width
    @screen_height   = screen_height
  end

  # Deletes all cookies from the browser
  def delete_cookies
    @log.info('Deleting the ' + @browser_name + ' browser cookies')
    @driver.manage.delete_all_cookies
  end

  # Moves the browser window to set position on screen
  def move_browser(x_position, y_position)
    x_position ? x_position : x_position = 0
    y_position ? y_position : y_position = 0

    @log.info('Moving the browser to: ' + x_position.to_s + ', ' + y_position.to_s)
    @driver.manage.window.move_to(x_position, y_position)
  end

  # Opens google
  def open_google
    self.delete_cookies
    @driver.navigate.to('http://www.google.com')

    # Return GoogleHome page instance
    GoogleHomePage.new('GoogleHomePage', @driver, @log)
  end

  def set_timeout(timeout)
    @log.info('Setting the selenium timeout to: ' + timeout.to_s)
    @driver.manage.timeouts.implicit_wait = timeout
  end

  def set_window_size(screen_width, screen_height)
    # Set screen_width and screen_height if defined
    screen_width   ? screen_width   : screen_width   = 1280
    screen_height  ? screen_height  : screen_height  = 1024

    @log.info('Setting the screen window size to: ' + screen_width.to_s + 'x' + screen_height.to_s)
    # @note this is currently supported in Chrome and FF
    @driver.manage.window.resize_to(screen_width, screen_height)
  end

  # Starts the browser
  def start_browser(browser)
    @log.info('Starting the browser: ' + browser)
    # Define browser to use from config
      driver = Selenium::WebDriver.for :firefox
  end

end