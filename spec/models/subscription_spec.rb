require 'spec_helper'

describe Subscription do
  describe "#trial?" do
    it "is true when subscription plan name is trial" do
      trial_plan = Factory.build(:subscription_plan, :name => "trial")
      subscription = Factory.build(:subscription, :subscription_plan => trial_plan)
      subscription.should be_trial
    end

    it "is false when subscription plan name is not trial" do
      plan = Factory.build(:subscription_plan, :name => "premium")
      subscription = Factory.build(:subscription, :subscription_plan => plan)
      subscription.should_not be_trial
    end
  end

end
