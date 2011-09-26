class GamesWordList < ActiveRecord::Base
  has_many :games
  has_many :word_lists
end
