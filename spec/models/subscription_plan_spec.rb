require 'spec_helper'

describe SubscriptionPlan do
  it "should create from factory" do
    Factory(:subscription_plan)
  end

  describe ".trial" do
    it "can be created from a factory" do
      Factory(:subscription_plan)
    end

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

  describe "#upgrades" do
    context "when a premium plan" do

      let!(:three_teachers)     { Factory(:subscription_plan, :name => 'premium', :max_teachers => 3) }
      let!(:five_teachers)      { Factory(:subscription_plan, :name => 'premium', :max_teachers => 5) }
      let!(:five_teacher_trial) { Factory(:subscription_plan, :name => 'trial',   :max_teachers => 5) }
      let!(:infinite_teachers)  { Factory(:subscription_plan, :name => 'premium', :max_teachers => SubscriptionPlan::UNLIMITED_FLAG) }

      it "returns premium plans with a larger number of max teachers" do
        three_teachers.upgrades.should == [five_teachers, infinite_teachers]
        five_teachers.upgrades.should == [infinite_teachers]
        infinite_teachers.upgrades.should == []
      end
    end

    context "when not a premium plan" do
      let!(:three_teachers)           { Factory(:subscription_plan, :name => 'trial',   :max_teachers => 3) }
      let!(:five_teachers)            { Factory(:subscription_plan, :name => 'trial',   :max_teachers => 5) }
      let!(:five_teacher_premium)     { Factory(:subscription_plan, :name => 'premium', :max_teachers => 5) }
      let!(:infinite_teachers)        { Factory(:subscription_plan, :name => 'trial',   :max_teachers => SubscriptionPlan::UNLIMITED_FLAG) }
      let!(:infinite_teacher_premium) { Factory(:subscription_plan, :name => 'premium', :max_teachers => SubscriptionPlan::UNLIMITED_FLAG) }

      it "returns all plans with a higher number of max teachers" do
        three_teachers.upgrades.should == [five_teachers, five_teacher_premium, infinite_teachers, infinite_teacher_premium]
        five_teachers.upgrades.should == [five_teacher_premium, infinite_teachers, infinite_teacher_premium]
        infinite_teachers.upgrades.should == [infinite_teacher_premium]
        infinite_teacher_premium.upgrades.should == []
      end
    end
  end
end
