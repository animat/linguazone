ActiveAdmin.register Activity do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :node_options
    end
    f.buttons
  end
end
