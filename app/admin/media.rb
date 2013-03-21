ActiveAdmin.register Media do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Media" do
      f.input :media_category
      f.input :name
      f.input :image, :hint => f.template.image_tag(f.object.image.url(:thumb))
    end
    f.buttons
  end
end
