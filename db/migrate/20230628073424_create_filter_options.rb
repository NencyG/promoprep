class CreateFilterOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :filter_options do |t|
      t.string :name
      t.boolean :is_active
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
