require 'spec_helper'

describe GameDataController do
  let(:language) { Factory(:language) }
  let(:activity) { Factory(:activity, :game_type => "MultipleAnswer") }

  describe "POST #create" do
    let(:arguments) { {"activity_id"=>activity.id, "language_id"=>language.id, "game_type"=>"MultipleAnswer", "nodes"=>[{"question"=>"asdfa", "options"=>"one,two", "response"=>"two"}], "description"=> "cool", "option_list"=>[{"response"=>["one", "two"]}]}}
    let(:user) { Factory(:user) }

    before do
      subject.stubs :current_user => Factory(:user)
      post :create, arguments
    end

    it "creates a game" do
      Game.count.should > 0
    end

    it "creates nodes" do
      Game.first.game_data.nodes.length.should > 0
    end
  end
end
