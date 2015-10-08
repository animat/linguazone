class  Api::V2::SchoolsController < ApplicationController
  def show
    @school = School.find(params[:id])
    @courses = Course.find_active_courses_at_school(@school)
    # TODO: Limit the amount of information that is included with user!
    render json: {school: @school, courses: @courses.as_json(:include => :user)}
  end
end
