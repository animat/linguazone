# An example is for one input per node.
#
# Examples:
#   node_key_name:     "response"
#   node_value:        "gato"
#   input_description: "the answer response"
#
#   node_key_name:     "response"
#   node_value:        "http://flic.kr/cat.jpg"
#   input_description: "an image response"
class Example < ActiveRecord::Base
  belongs_to :language
  belongs_to :activity

  def self.for(language, activity)
    result = self.find_all_by_language_id_and_activity_id(language.id, activity.id)
    return result if result.length > 0
    Rails.logger.warn "Could not find Example for #{activity} with #{language}. Resorting to Default."
    self.find_all_by_activity_id_and_default(activity.id, true)
  end

  def game_data
    GameData.new
  end

  has_attached_file :image,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => "linguazone",
    :s3_protocol => "http",
    :url => ":s3_domain_url",
    :path => "media/image/example/:id.:extension"
end
