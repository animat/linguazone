class ChangeGamesKeywordsTypeToVarChar < ActiveRecord::Migration
  def up
    change_column :games_keywords, :keyword, :string
  end

  def down
    change_column :games_keywords, :keyword, :text
  end
end
