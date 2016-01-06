class AddOptionalMediaToAb < ActiveRecord::Migration
  def change
    create_table :ab_media_resources do |t|
      t.string      :source
      t.text        :embed
      t.text        :description, null: true
      t.integer     :post_id
      t.timestamps                null: false
    end
  end
end
