class ContactMailer < ActionMailer::Base
  default :from    => "LinguaZone.com <info@linguazone.com>"
  default :reply_to => "info@linguazone.com" 
  
  def password_reset_instructions(user)  
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)  
    mail :to => user.email, :subject => "Password Reset Instructions"
  end
  
  def contact_email(email_params)
    @name = email_params[:name]
    @address = email_params[:address]
    @school = email_params[:school]
    @city = email_params[:city]
    @state = email_params[:state]
    @main_msg = email_params[:body]
    mail :to => "info@linguazone.com", :subject => "LinguaZone contact form"
  end
  
  def report_bug(params)
    if params[:user_id] and params[:user_id] != 0 and params[:user_id] != "undefined"
      @user = User.find(params[:user_id])
      @reply_address = '"'+@user.display_name+'" <'+@user.email+'>'
    else
      @reply_address = ""
    end
    @main_msg = params[:body]
    @game_id = params[:game_id]
    mail :to => "info@linguazone.com", :subject => "LinguaZone bug report", :reply_to => @reply_address
  end
  
  def updated_media_notify_artist(email_addr, id, descrip, assigned_to, notes)
    @descrip = descrip
    @assigned_to = assigned_to
    @notes = notes
    @id = id
    mail :to => email_addr, :subject => "[LZ] New note on your clip art: #{@descrip}", :reply_to => "Colin Angevine <info@linguazone.com>"
  end
  
  def updated_media_notify_admin(params, descrip, notes, id)
    @descrip = descrip
    @notes = notes
    @assigned_to = params[:assigned_to]
    @id = id
    mail :to => "info@linguazone.com, magistraroberts@gmail.com", :subject => "[LZ] New clip art uploaded: #{@descrip}"
    content_type  "text/html"
  end

end
