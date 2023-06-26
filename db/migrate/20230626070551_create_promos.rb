class CreatePromos < ActiveRecord::Migration[7.0]
  def change
    create_table :promos do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.text :description
      t.references :companies, null: false, foreign_key: true

      t.timestamps
    end
  end
end
