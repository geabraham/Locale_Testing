# Dir.chdir "/Users/gabraham/medidata/subjects"
# system "bundle exec rails c"
# a = ActivationCode.new
# puts a
def create_pe(key,value)
    Thread.current[:current_user_uri] = 'com:mdsol:users:gabraham'
    
    s = Subject.new(
                    study_uuid: SecureRandom.uuid,
                    study_site_uuid: SecureRandom.uuid,
                    site_uuid: SecureRandom.uuid,
                    subject_identifier: "Subject-#{rand(1000)}")
                    s.save!
                    
                    ac = ActivationCode.new
                    ac.save!
                    
                    #tou_don = TouDpnAgreement.where(
                    #tou_dpn = TouDpnAgreement.offset(rand(TouDpnAgreement.count)).first
                    tou_dpn = TouDpnAgreement.where(language_code:key,country_code:value).last
                    pe = PatientEnrollment.new(
                                               activation_code: ac,
                                               subject: s,
                                               tou_dpn_agreement: tou_dpn,
                                               language_code: tou_dpn.language_code,
                                               enrollment_type: 'in-person',
                                               country_code:value )
                                               pe.save!
                                               
                                               puts "Country #{value} Language #{key} Activation Code #{pe.activation_code.activation_code}"
                                               

end


locale = {
"ara"=>"ISR",
"cze"=>"CZE",
"dan"=>"DNK",
"deu"=>"DEU",
"eng"=>"USA",
"spa"=>"ESP",
"fra"=>"FRA",
"heb"=>"ISR",
"hun"=>"HUN",
"ita"=>"ITA",
"jpn"=>"JPN",
"kor"=>"KOR",
"nld"=>"NLD",
"pol"=>"POL",
"rus"=>"RUS",
"vie"=>"VNM",
"zho"=>"CHN",
"chi"=>"CHN",
}
locale1 = {
    "spa"=>"USA",
    "fra"=>"CAN",
}


locale.each do |key,value|
  for i in 1..2 do
    create_pe(key,value)
  end

end

locale1.each do |key,value|
  for i in 1..2 do
    create_pe(key,value)
  end

end

create_pe("eng","USA")





def run_in_browser(code)
    code = 'qw1er1'
    require 'selenium-webdriver'
    require 'watir-webdriver'
    browser = Watir::Browser.new :ie
    browser.goto 'https://minotaur-sandbox.imedidata.net'
    browser.text_field(:id=>'code').set code
    browser.button(:id => 'activate-button').click
end

