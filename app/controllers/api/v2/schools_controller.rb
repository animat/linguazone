class  Api::V2::SchoolsController < ApplicationController
  def show
    @school = School.find(params[:id])
    @courses = Course.find_active_courses_at_school(@school)
    render json: {school: @school, courses: @courses.as_json(:include => :user)}
  end
end
