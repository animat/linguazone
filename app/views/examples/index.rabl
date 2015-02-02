object @examples

attributes :id, :language_id, :node_key_name, :node_value, :activity_id, :input_text, :hint, :input_description

code :image_url do |example|
  example.image.url unless example.nil?
end
