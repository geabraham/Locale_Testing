require 'capybara'
require 'capybara/rspec'
require 'yaml'
require 'site_prism'
require_relative '/Users/gabraham/medidata/MIST/pages/common/base_page.rb'



#
    #
    # element :add_subject_link, '#_ctl0_Content_ListDisplayNavigation_lbAddSubject'
    # element :add_subject_button, '#_ctl0_Content_CRFRenderer_footer_SB'
    # # sections :course_table_new, RolesSections ,'table[id=_ctl0_Content_ListDisplayNavigation_dgObjects] > tbody > tr'
    # element :username, '#UserLoginBox'
    # element :password, '#UserPasswordBox'
    # element :login_button, '#LoginButton'
    # element :study_name, '#_ctl0_PgHeader_TabTextHyperlink1'
    element :second_site_name, '#_ctl0_Content_ListDisplayNavigation_dgObjects tr:nth-of-type(3) td:nth-of-type(2)'
    # # sections :roles_sections, RolesSections, 'div[class=overflow-scroll] > table > tbody > tr'
    # element :course_tabletest, 'table[id=_ctl0_Content_ListDisplayNavigation_dgObjects]'
    # element :subject_name, '#_ctl0_Content_CRFRenderer_field11652_11652_CRFControl_11652_CRFControl_Text'

    def login_rave
      @session = Capybara::Session.new(:selenium)
      @session.visit "https://conlabtesting93.mdsol.com/"
      @session.find('#UserLoginBox').set 'defuser'
      @session.find('#UserPasswordBox').set 'password'
      @session.find('#LoginButton').click
    end


    def select_rave_study_site
      @study_name = @session.find('#_ctl0_PgHeader_TabTextHyperlink1').text
      @study_site_name = @session.find('#_ctl0_Content_ListDisplayNavigation_dgObjects tr:nth-of-type(3) td:nth-of-type(2)').text
      second_site_name.click
      # click_link(@study_site_name)

    end

    def get_study_site_name
      @study_site_name
    end

    def get_study_name
      @study_name
    end


    def add_subject
      @subject_name = "TESTSUBJECT_#{[*('A'..'Z')].sample(3).join}"
      @session.find('#_ctl0_Content_ListDisplayNavigation_lbAddSubject').click
      @session.find('#_ctl0_Content_CRFRenderer_field11652_11652_CRFControl_11652_CRFControl_Text').set @subject_name
      @session.find('#_ctl0_Content_CRFRenderer_footer_SB').click
    end


#
# elements :course_table, 'table[id=course_assignments_table] > tbody > tr[id^=course]'

#
# def verify_course_status(course)
#   status = ""
#   course_table.each do |courses|
#     if courses.text.include?(course)
#       columns = courses.all('td').take(2)
#       status = columns.last.text
#       break
#     end
#   end
#   status
# end