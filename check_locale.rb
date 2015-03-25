require 'capybara'
require 'capybara/rspec'
require 'yaml'

Dir.new('/Users/gabraham/medidata/minotaur/config/locales/').each {|file|
  if file == '.' or file == '..'

  else

CONFIG = YAML::load(File.open("/Users/gabraham/medidata/minotaur/config/locales/#{file}"))
locale = file.slice(0..(file.index('.')-1))

yaml_heading = CONFIG[locale]['activation_codes']['index']['code_heading'].gsub(/\n/,'')
yaml_text = CONFIG[locale]['activation_codes']['index']['code_instruction'].gsub(/\n/,'')
session = Capybara::Session.new(:selenium)
session.visit "https://shield-sandbox.imedidata.net/?language_code=#{locale}"

para = session.find(".activation-code-content p").text
header = session.find(".activation-code-content h3").text
puts "Checking paragraph for #{locale}:"
if para.eql?(yaml_text)
else
  open('activation_code_page.txt', 'a') { |f|
    f.puts "#{locale}: INCORRECT \n yml value: #{yaml_text} \n page value: #{para}"
  }

end
puts "Checking header for #{locale}:"
if header.eql?(yaml_heading)
else
  open('activation_code_page.txt', 'a') { |f|
    f.puts "#{locale}: INCORRECT \n yml value: #{yaml_heading} \n page value: #{header}"
  }

end
session.driver.browser.close

end
}