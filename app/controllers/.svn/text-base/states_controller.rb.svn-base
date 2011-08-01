class StatesController < ApplicationController
  
  def index
    @states = State.all(:conditions => ["intl = 0"])
    @intl_states = State.all(:conditions => ["intl = 1"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @courses }
    end
  end

  def show
    @state = State.find(params[:id])
    @schools = School.all(:conditions => ["state_id = ?", params[:id]], :order => "name")
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @school }
    end
  end
  
end
