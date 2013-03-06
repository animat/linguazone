require 'lib/temp_file'

class ImagesController < ApplicationController
  def create
    filename = params[:qqfile]
    form_data = request.body.read
    file = TempFile.new(truncate(form_data), filename, get_content_type(form_data))
    image = Image.new
    image.image = file
    image.user = current_user
    image.save!
    render :json => { :url => image.image.url }
  end

  private

    def get_content_type(form_data)
      match_data = form_data.scan /Content-Type: (.+)$/
      match_data[0][0]
    end

    # multi-part form comes with some extra lines of data we don't need.
    # this will return only the image data
    def truncate(form_data)
      form_data.to_a[4..-2].join
    end
end
