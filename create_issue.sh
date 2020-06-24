rake -f /usr/src/redmine/Rakefile redmine:email:receive_imap RAILS_ENV="production" 
tracker=Support host=imap.gmail.com port=993 ssl=1 username=${gsuite_user} 
password=${email_password} folder=$1 project=$1 status=0 no_permission_check=1 
unknown_user=create no_account_notice=1 allow_override=all 
move_on_failure=redmine_fail move_on_success=redmine_pass
