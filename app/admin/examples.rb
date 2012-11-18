ActiveAdmin.register Example do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :image, :hint => f.template.image_tag(f.object.image.url(:thumb))
      f.input :language
      f.input :activity
    end
    f.buttons
  end
end
