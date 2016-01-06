class  Api::V2::StudentsController < ApplicationController
  def create
    unless (params[:email] && params[:password] && params[:role] && params[:firstName] && params[:lastName])
      return missing_params
    end
    
    @s = User.new(email: params[:email], password: params[:password], role: params[:role],
                  first_name: params[:firstName].titleize, last_name: params[:lastName].titleize)
    @s.display_name = "#{@s.first_name} #{@s.last_name}"
    @s.school_id = 0
    @s.discount_id = 0
    @s.receive_newsletter = 0
    @s.default_language_id = 0
    
    if @s.save
      render json: {message: "Saved successfully."}, status: 201
    else
      render json: {message: "Error creating account."}, status: 400
    end
  end
  
  def show
    @stu = User.find(params[:id])
    @registered_courses = CourseRegistration.includes(:course).all(:conditions => ["user_id = ?", @stu.id])
    
    return invalid_credentials unless request.headers["Authorization"]
    @auth = JSON.parse ActiveSupport::JSON.decode request.headers["Authorization"]
    @user = User.find_by_id_and_single_access_token(@auth["uid"], @auth["token"]) || nil
    return invalid_credentials unless @user
    
    @user.reset_single_access_token!
    # TODO: This header is not being intercepted by Angular properly... must be included in data response as "token"
    response.headers["X-AUTH-TOKEN"] = @user.single_access_token
    
    return permission_denied_api unless params[:id].to_i == @user.id
    
    render json: {"token" => @user.single_access_token, "student_data" => {"student" => @stu, 
                  "registrations" => @registered_courses.as_json(:include => {:course => {:include => 
                                                                              {:user => {:include => :school}}}})}} 
  end
  
  def validate_unique_email
    in_use = User.is_email_in_use(params[:email])
    render json: { email_in_use: in_use }
  end
end
