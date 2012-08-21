class CourseRegistrationsController < ApplicationController
  respond_to :html
  
  def destroy
    @cr = CourseRegistration.find(params[:id])
    @cr.destroy
    redirect_to :back
  end
end