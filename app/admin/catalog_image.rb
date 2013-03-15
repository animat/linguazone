ActiveAdmin.register CatalogImage do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "CatalogImage" do
      f.input :name
      f.input :image, :hint => f.template.image_tag(f.object.image.url(:thumb))
    end
    f.buttons
  end
end
