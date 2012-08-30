class FeedItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :sourceable, :polymorphic => true
end
