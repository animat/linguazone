class  Api::V3::AboutController < ApplicationController
	def get_languages
		@languages = Language.all(:order => "name")
		render json: @languages
	end
end