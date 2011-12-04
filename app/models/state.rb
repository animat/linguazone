class State < ActiveRecord::Base
  has_many :schools
  default_scope order(:name)

  scope :international, where(:intl => true)
  scope :national,      where(:intl => false)
end
