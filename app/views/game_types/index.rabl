object @game_type

attributes :questions, :name, :lists, :activity_id, :language_id

code :node do |g|
  g.example_node_for(@language)
end
