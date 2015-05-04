class  Api::V2::CoursesController < ApplicationController
  def show
    @course = Course.find(params[:id])
    render json: {:course => @course, 
                  :games => @course.available_games.showing, 
                  :word_lists => @course.available_word_lists.showing,
                  :posts => @course.available_posts.showing}
  end
end
