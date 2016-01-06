class AddTokenToUser < ActiveRecord::Migration
  def change
    # Authlogic::ActsAsAuthentic::SingleAccessToken
    add_column :users, :single_access_token, :string
  end
end
