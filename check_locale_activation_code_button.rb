require 'capybara'
require 'capybara/rspec'
require 'yaml'

Dir.new('/Users/gabraham/medidata/minotaur/config/locales/').each {|file|
  if file == '.' or file == '..'

  else

CONFIG = YAML::load(File.open("/Users/gabraham/medidata/minotaur/config/locales/#{file}"))
locale = file.slice(0..(file.index('.')-1))

activation_code = CONFIG[locale]['activation_codes']['index']['btn_activate']
session = Capybara::Session.new(:selenium)
session.visit "https://shield-sandbox.imedidata.net/?language_code=#{locale}"

activate_button_text = session.find("#activate-button").text
puts "Checking Activation Code button for #{locale}:"
if activate_button_text.eql?(activation_code)
  open('activationcode.txt', 'a') { |f|
    f.puts "#{locale}: CORRECT \n yml value: #{activation_code} \n page value: #{activate_button_text}"
  }
else
  open('activationcode.txt', 'a') { |f|
    f.puts "#{locale}: INCORRECT/WRONG \n yml value: #{activation_code} \n page value: #{activate_button_text}"
  }
end

session.driver.browser.close

end
}