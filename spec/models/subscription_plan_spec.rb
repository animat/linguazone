require 'spec_helper'

describe SubscriptionPlan do
  describe ".trial" do
    context "when a trial plan exists" do
      let!(:trial_plan) { Factory(:subscription_plan, :name => "trial") }

      it "returns the trial plan" do
        SubscriptionPlan.trial.should == trial_plan
      end
    end

    context "when no trial plan exists" do
      it "returns nil" do
        SubscriptionPlan.trial.should be_nil
      end
    end
  end
end
