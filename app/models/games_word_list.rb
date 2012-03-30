class GamesWordList < ActiveRecord::Base
  belongs_to :game
  has_one :activity, :through => :game
  belongs_to :word_list
end
