class WordList < ActiveRecord::Base
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  belongs_to :language
  has_many :available_word_lists, :dependent => :destroy

  def header_text
    "#{self.description}"
  end
end
