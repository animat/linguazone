object @examples

attributes :id, :language_id, :question_name, :activity_id, :input_text, :hint, :display_label

code :image_url do |example|
  example.image.url unless example.nil?
end
