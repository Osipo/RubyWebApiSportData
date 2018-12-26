class CreateNewsItems < ActiveRecord::Migration[5.2]
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :content
      t.text :url

      t.timestamps
    end
  end
end
