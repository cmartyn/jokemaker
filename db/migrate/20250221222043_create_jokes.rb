class CreateJokes < ActiveRecord::Migration[8.0]
  def change
    create_table :jokes do |t|
      t.text :prompt
      t.text :secret
      t.text :content

      t.timestamps
    end
    add_index :jokes, :secret, unique: true
  end
end
