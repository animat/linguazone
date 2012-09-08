class SubscriptionController < ApplicationController
  autocomplete :school, :name

  def new
    render :controller => "teachers", :action => "new"
  end

  def renew
    @subscription = Subscription.new
    @basic_subscriptions = SubscriptionPlan.all(:conditions => ["name = 'basic'"], :order => "name, cost")
    @premium_subscriptions = SubscriptionPlan.all(:conditions => ["name = 'premium'"], :order => "name, cost")
  end

  def join_form
    @subscription = Subscription.find_by_pin(params[:pin])
    if @subscription.nil?
      flash[:error] = "Sorry - that pin number does not match any school in the database."
      redirect_to :controller => "about", :action => "pricing"
    else
      @school = @subscription.school
      session[:subscription] = @subscription
      session[:school] = @school
      @new_teacher = User.new
      unless @school.is_availability?
        redirect_to :action => "no_availability"
      end
    end
  end

  def join
    if params[:user].nil?
      flash[:error] = "Please fill out the fields below before continuing."
      render :action => "join_form"
    elsif params[:user][:first_name].empty? or params[:user][:last_name].empty? or params[:user][:email].empty? or params[:user][:password].empty?
      flash[:error] = "Please fill out all of the fields before continuing."
      @subscription = session[:subscription]
      @school = session[:school]
      @new_teacher = User.new(params[:user])
      render :action => "join_form"         # TODO: Gap in security. Users can create an error, then simply join without upgrading
    else
      if User.is_email_in_use(params[:user][:email])
        @subscription = session[:subscription]
        @school = session[:school]
        @new_teacher = User.new(params[:user])
        flash[:error] = "That email address is already in our database.<br />Please get in touch if you'd like help reactivating your account."
        render :action => "join_form"
      else
        @teacher = User.new(params[:user])
        @teacher.subscription = session[:school].subscription
        @teacher.school = session[:school]
        @teacher.role = "teacher"

        @teacher.save
        UserSession.create @teacher

        unless params[:upgrade_plan].nil?
          redirect_to :controller => "subscription", :action => "upgrade", :subscription_plan_id => params[:upgrade_plan], :new_teacher => true
        else
          redirect_to :controller => "teachers", :action => "getting_started"
        end
      end
    end
  end

  def no_availability
    @school = session[:school]
    @current_plan = @school.subscription.subscription_plan
    session[:subscription] = @school.subscription
    @upgrade_plan = SubscriptionPlan.first(:conditions => ["name = ? and (max_teachers > ? or max_teachers = -1)", @current_plan.name, @current_plan.max_teachers])
    @cost = @upgrade_plan.cost - @current_plan.cost
    @new_teacher = User.new
  end

  def upgrade
    unless params[:subscription].nil?
      @new_plan = SubscriptionPlan.find(params[:subscription][:subscription_plan_id]) # Directed from a trial upgrade
      @renew = true
    end
    unless params[:subscription_plan_id].nil?
      @new_plan = SubscriptionPlan.find(params[:subscription_plan_id]) # Directed from a paying account upgrade
      @renew = false
    end

    @current_plan = current_user.subscription.subscription_plan
    @subscription = current_user.subscription

    @cost = @current_plan.cost - @new_plan.cost
    @cost = @cost.abs
    @subscription.subscription_plan = @new_plan
    if @renew
      @subscription.expired_at = Time.now.advance(:years => 1)
    end
    @subscription.save

    current_user.subscription = @subscription
    current_user.save

    @other_teachers = User.find_all_by_school_id(current_user.school_id)
    unless @other_teachers.nil?
      @other_teachers.each do |ot|
        ot.subscription = @subscription
        ot.save
      end
    end

    @users = User.all(:conditions => ["subscription_id = ?", @subscription.id])
    @users.each do |user|
      unless user.nil? or user.email.nil?
        InvoiceMailer.upgrade_invoice(user.email, current_user, @subscription, @cost).deliver
      end
    end
    InvoiceMailer.upgrade_invoice("info@linguazone.com", current_user, @subscription, @cost).deliver

    flash[:success] = "Your subscription has been upgraded.<br />Please check your email for an invoice that you can give to your school's business office.<br />Payment is due within one month."
    if params[:new_teacher] == "true"
      redirect_to :controller => "teachers", :action => "getting_started"
    else
      redirect_to :controller => "teachers", :action => "index"
    end
  end

  def extend
    @subscription = Subscription.find(params[:subscription_id])
    @subscription.expired_at = @subscription.expired_at.advance(:years => 1)
    @subscription.save

    current_user.subscription = @subscription
    current_user.save

    @other_teachers = User.find_all_by_school_id(current_user.school_id)
    unless @other_teachers.nil?
      @other_teachers.each do |ot|
        ot.subscription = @subscription
        ot.save
      end
    end

    @users = User.all(:conditions => ["subscription_id = ?", @subscription.id])
    @users.each do |user|
      InvoiceMailer.extend_invoice(user.email, current_user, @subscription, current_user.subscription.subscription_plan.cost).deliver
    end
    InvoiceMailer.extend_invoice("info@linguazone.com", current_user, @subscription, current_user.subscription.subscription_plan.cost).deliver

    flash[:success] = "Your subscription has been renewed for one year.<br />Please check your email for an invoice that you can give to your school's business office.<br />Payment is due within one month."
    redirect_to :controller => "teachers"
  end

  def confirm
    flash[:notice] = nil
    flash[:error] = nil

    if session[:teacher].nil?
      redirect_to :controller => "teachers", :action => "new"
    elsif session[:school].nil?
      redirect_to :controller => "school", :action => "check"
    elsif session[:subscription].nil?
      redirect_to :controller => "about", :action => "us"
    else
      @teacher = session[:teacher]
      @school = session[:school]
      @subscription = session[:subscription]
      if @subscription.trial?
        redirect_to :controller => "subscription", :action => "create"
      end
    end
  end

  def create
    # TODO for some reason rails 3 thinks these objects coming out
    # of the session are already persisted and will do an UPDATE in
    # SQL instead of an INSERT.
    @subscription = Subscription.new session[:subscription].attributes
    @school = School.new session[:school].attributes
    @teacher = User.new session[:teacher].attributes

    if @subscription.trial?
      @subscription.expired_at = Time.now.advance(:weeks => 2)
    else
      @subscription.expired_at = Time.now.advance(:years => 1)
    end
    @subscription.pin = 10001 + rand(89998)

    @teacher.school = @school
    @teacher.subscription = @subscription

    @teacher.persistence_token = nil

    @teacher.save
    UserSession.create @teacher

    if @subscription.trial?
      InvoiceMailer.trial_confirmation(@teacher.email, @teacher).deliver
      InvoiceMailer.trial_details(@teacher).deliver
    else
      InvoiceMailer.new_invoice(@teacher.email, @teacher, @subscription, @subscription.subscription_plan.cost).deliver
      InvoiceMailer.new_invoice("info@linguazone.com", @teacher, @subscription, @subscription.subscription_plan.cost).deliver
      InvoiceMailer.new_invoice("magistraroberts@hotmail.com", @teacher, @subscription, @subscription.subscription_plan.cost).deliver
    end

    redirect_to :controller => "teachers", :action => "getting_started"
  end

end
