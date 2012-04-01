class ContactMailer < ActionMailer::Base
  
  default_url_options[:host] = "beta.linguazone.com" 
  
  def password_reset_instructions(user)  
    subject       "Password Reset Instructions"  
    from          "LinguaZone.com "  
    recipients    user.email  
    sent_on       Time.now  
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
    content_type "text/html"
  end
  
  def contact_email(email_params)
    recipients    "info@linguazone.com"
    from          "LinguaZone.com "
    reply_to      '"'+email_params[:name]+'" <'+email_params[:address]+'>'
    subject       "LinguaZone contact form"
    body          :name => email_params[:name], :address => email_params[:address], :school => email_params[:school], :city => email_params[:city], :state => email_params[:state], :body => email_params[:body]
    content_type  "text/html"
  end
  
  def report_bug(params)
    if params[:user_id] and params[:user_id] != 0 and params[:user_id] != "undefined"
      @user = User.find(params[:user_id])
      reply_to    '"'+@user.display_name+'" <'+@user.email+'>'
    end
    recipients    "info@linguazone.com"
    from          "LinguaZone.com "
    subject       "LinguaZone bug report"
    body          :body => params[:body], :game_id => params[:game_id]
    content_type   "text/html"
  end
  
  def updated_media_notify_artist(email_addr, id, descrip, assigned_to, notes)
    recipients    email_addr
    from          "LinguaZone.com "
    reply_to      "Colin Angevine <info@linguazone.com>"
    subject       "[LZ] New note on your clip art: "+descrip
    body          :descrip => descrip, :assigned_to => assigned_to, :notes => notes, :id => id
    content_type  "text/html"
  end
  
  def updated_media_notify_admin(params, descrip, notes, id)
    recipients    "info@linguazone.com, magistraroberts@hotmail.com"
    from          "LinguaZone.com "
    reply_to      "Colin Angevine <info@linguazone.com>"
    subject       "[LZ] New clip art uploaded: "+descrip
    body          :descrip => descrip, :notes => notes, :assigned_to => params[:assigned_to], :id => id
    content_type  "text/html"
  end

end
