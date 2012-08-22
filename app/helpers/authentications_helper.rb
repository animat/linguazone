module AuthenticationsHelper
  def single_line_authentications(user)
    str = ""
    unless user.has_generic_lz_email?
      str << "#{user.email}, "
    end
    user.authentications.each do |a|
      str << "#{a.provider.titleize}, "
    end
    str
  end
end
