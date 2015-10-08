class UserSession < Authlogic::Session::Base
  single_access_allowed_request_types = :all
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end
