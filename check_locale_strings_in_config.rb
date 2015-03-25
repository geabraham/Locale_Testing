#ABOUT THIS SCRIPT
#WITH ENGLISH FILE AS BASE,
#Check if the string is present in all other files in the locale directory and raise if not present
#The script is a bit ugly for a quick win for checking

require 'capybara'
require 'capybara/rspec'
require 'yaml'

Dir.new('/Users/gabraham/medidata/minotaur/config/locales/').each {|file|
  if file == '.' or file == '..'

  else

    CONFIG = YAML::load(File.open("/Users/gabraham/medidata/minotaur/config/locales/#{file}"))
    locale = file.slice(0..(file.index('.')-1))
#------------
  #Security Question check
    (0..10).each do |i|
      @value = i

        if CONFIG[locale]['security_questions'][i].nil?
          puts "locale =#{locale}  CONFIG['eng']['security_questions'][#{@value}]['name']  does not exist"
        end
    end

#-----------
  #Application Check
    # ['patient_management','btn_launch']
  fields = ['title','btn_cancel','btn_open','btn_agree','btn_next','btn_continue','required','patient_management','btn_launch']
    fields.each do |field|
        if CONFIG[locale]['application'][field].nil?
          puts "locale =#{locale}  CONFIG[#{locale}]['application'][#{field}]  does not exist"
        end
    end

#-----------
    #Registration
    fields = ['form_heading','welcome','terms_of_use','tou_agreement','email_form','password_form','security_question_form']
         map = {
             "welcome"=>["header","welcome_message","register_1","register_2","download","login"],
             "terms_of_use"=>["tou_header"],
             "tou_agreement"=>["modal_confirm","modal_cancel"],
             "email_form"=>["form_instruction","email_label","reenter_label","validation_error","mismatch_error","modal_already_registered"],
             "password_form"=>["form_instruction_1","form_instruction_1_bold","form_instruction_1_2","ul_1","ul_2","ul_3","ul_4","password_label","reenter_label","mismatch_error","validation_error"],
             "security_question_form"=>["form_instruction","form_instruction_bold","dropdown_placeholder","answer_label","answer_placeholder","btn_create","modal_error","modal_error_ok"],
             }
    fields.each do |field|
      if map[field].nil?
        if CONFIG[locale]['registration'][field].nil?
          puts "locale =#{locale}  CONFIG[#{locale}]['registration'][#{field}] does not exist"
        end
      else
        map[field].each do |val|
          if CONFIG[locale]['registration'][field][val].nil?
            puts "locale =#{locale}  CONFIG[#{locale}]['registration'][#{field}][#{val}] does not exist"
          end
        end
      end

    end

#---------------
    #Download
    fields = ["header","modal_open","modal_download"]
    fields.each do |field|
      if CONFIG[locale]['download'][field].nil?
        puts "locale =#{locale}  CONFIG[#{locale}]['download'][#{field}] does not exist"
      end

    end


#--------------
    #Error
    fields=["error","wrong","helpdesk_html","timeout","status_403","status_404","status_422","status_500","status_","status_503","activation_code_invalid_error","activation_code_backend_error",
            "invalid_subject_id_registration_error","existing_email_registration_error","registration_backend_error","no_patient_enrollments_message","subject_not_available_message"]

    map = {"status_403"=>["heading","message"] ,"status_404"=>["heading","message"],"status_422"=>["heading","message"],"status_500"=>["heading","message"] ,
           "status_"=>["heading","message"] ,"status_403"=>["heading","message"],"activation_code_invalid_error"=>["message"],"activation_code_backend_error"=>["message"],
           "invalid_subject_id_registration_error"=>["message"],"existing_email_registration_error"=>["message"], "registration_backend_error"=>["message"],
           "no_patient_enrollments_message"=>["message"],"subject_not_available_message"=>["message"]}
    if CONFIG[locale]['error'].nil?
      puts "locale =#{locale}  CONFIG[#{locale}]['error']does not exist"
    else

      fields.each do |field|
        if map[field].nil?

          if CONFIG[locale]['error'][field].nil?
                puts "locale =#{locale}  CONFIG[#{locale}]['error'][#{field}] does not exist"
          end

        else
              map[field].each do |val|
                if CONFIG[locale]['error'][field][val].nil?
                  puts "locale =#{locale}  CONFIG[#{locale}]['error'][#{field}][#{val}] does not exist"
                end
              end
        end
      end

#
    end


  #----------------
  #pagination
  fields = ["total_results","per_page","first","next","last","previous","enter_a_valid_page_number"]
  if CONFIG[locale]['pagination'].nil?
    puts "locale =#{locale}  CONFIG[#{locale}]['pagination'] does not exist"
  else
    fields.each do |field|
     if CONFIG[locale]['pagination'][field].nil?
      puts "locale =#{locale}  CONFIG[#{locale}]['download'][#{field}] does not exist"
     end
    end

  end



  #------------------

  fields =["choose_study_and_site","study","site","invitation_form","enrollment_grid"]
  map = {"invitation_form"=>["add_a_patient_to","subject","no_subjects_available","country_language","subject_email","subject_initials","btn_add"],
         "enrollment_grid"=>["headers","statuses"]}
  if CONFIG[locale]['patient_management'].nil?
    puts "locale =#{locale}  CONFIG[#{locale}]['patient_management']does not exist"
  else

    fields.each do |field|
      if map[field].nil?

        if CONFIG[locale]['patient_management'][field].nil?
          puts "locale =#{locale}  CONFIG[#{locale}]['patient_management'][#{field}] does not exist"
        end

      else
        map[field].each do |val|
          if CONFIG[locale]['patient_management'][field][val].nil?
            puts "locale =#{locale}  CONFIG[#{locale}]['patient_management'][#{field}][#{val}] does not exist"
          end
        end
      end
    end

#
  end
  end


}