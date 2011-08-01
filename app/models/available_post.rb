class AvailablePost < ActiveRecord::Base
  belongs_to :course
  belongs_to :post
end
