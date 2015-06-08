class  Api::V2::StudentsController < ApplicationController
  def show
    @stu = User.find(params[:id])
    @registered_courses = CourseRegistration.all(:conditions => ["user_id = ?", @stu.id], :include => :course)
    render json: {"student_data" => {"student" => @stu.to_json, "registrations" => @registered_courses.to_json}}
  end
end
