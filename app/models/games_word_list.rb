class GamesWordList < ActiveRecord::Base
  belongs_to :game
  belongs_to :word_list
end
