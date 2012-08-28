class InvitationMailer < ActionMailer::Base
  helper :application
  default :from    => "LinguaZone.com <info@linguazone.com>"
  default :reply_to => "info@linguazone.com"
  
  def invite_student_to_course(student_email, course)
    @course = course
    @teacher = course.user
    mail :to => student_email, :subject => "Join #{@course.name} on LinguaZone.com"
  end
end
