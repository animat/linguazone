class  Api::V2::StatesController < ApplicationController
  def index
    @domestic = State.where(intl: false).all
    @intl = State.where(intl: true).all
    render json: {domestic: @domestic, intl: @intl}
  end
  
  def show
    @state = State.find(params[:id])
    @schools = School.where(state_id: @state.id).order("name ASC").all
    render json: {state: @state, schools: @schools}
  end
end
