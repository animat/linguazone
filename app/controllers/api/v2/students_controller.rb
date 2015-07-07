class  Api::V2::StudentsController < ApplicationController
  def show
    @stu = User.find(params[:id])
    @registered_courses = CourseRegistration.includes(:course).all(:conditions => ["user_id = ?", @stu.id])
    render json: {"student_data" => {"student" => @stu, 
                  "registrations" => @registered_courses.as_json(:include => {:course => {:include => 
                                                                              {:user => {:include => :school}}}})}} 
  end
end
