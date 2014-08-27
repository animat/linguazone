class ExamplesController < ApplicationController
  def index
    language = Language.find(params[:language_id])
    activity = Activity.find(params[:activity_id])
    @examples = Example.for(language, activity)
  end
end
