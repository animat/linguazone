class AdminController < ApplicationController
  
  def index
    
  end
  
  def view_users
    @trials_2006 = User.subscription_subscription_plan_id_equals(9).subscription_expired_at_less_than("2007-01-01 01:00:00").ascend_by_subscription_expired_at
    @subs_2006 = User.subscription_subscription_plan_id_does_not_equal(9).subscription_expired_at_less_than("2007-01-01 01:00:00").ascend_by_subscription_expired_at
    
    @trials_2007 = User.subscription_subscription_plan_id_equals(9).subscription_expired_at_greater_than("2007-01-01 01:00:00").subscription_expired_at_less_than("2008-01-01 01:00:00").ascend_by_subscription_expired_at
    @subs_2007 = User.subscription_subscription_plan_id_does_not_equal(9).subscription_expired_at_greater_than("2007-01-01 01:00:00").subscription_expired_at_less_than("2008-01-01 01:00:00").ascend_by_subscription_expired_at
    
    @trials_2008 = User.subscription_subscription_plan_id_equals(9).subscription_expired_at_greater_than("2008-01-01 01:00:00").subscription_expired_at_less_than("2009-01-01 01:00:00").ascend_by_subscription_expired_at
    @subs_2008 = User.subscription_subscription_plan_id_does_not_equal(9).subscription_expired_at_greater_than("2008-01-01 01:00:00").subscription_expired_at_less_than("2009-01-01 01:00:00").ascend_by_subscription_expired_at

    @trials_2009 = User.subscription_subscription_plan_id_equals(9).subscription_expired_at_greater_than("2009-01-01 01:00:00").subscription_expired_at_less_than("2010-01-01 01:00:00").ascend_by_subscription_expired_at
    @subs_2009 = User.subscription_subscription_plan_id_does_not_equal(9).subscription_expired_at_greater_than("2009-01-01 01:00:00").subscription_expired_at_less_than("2010-01-01 01:00:00").ascend_by_subscription_expired_at
    
    @trials_2010 = User.subscription_subscription_plan_id_equals(9).subscription_expired_at_greater_than("2010-01-01 01:00:00").subscription_expired_at_less_than("2010-10-15 16:33:31").ascend_by_subscription_expired_at
    @subs_2010 = User.subscription_subscription_plan_id_does_not_equal(9).subscription_expired_at_greater_than("2010-01-01 01:00:00").subscription_expired_at_less_than("2010-10-15 16:33:31").ascend_by_subscription_expired_at
  end
  
end
