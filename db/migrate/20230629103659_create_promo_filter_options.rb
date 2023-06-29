class CreatePromoFilterOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :promo_filter_options do |t|
      t.references :promo, null: false, foreign_key: true
      t.references :filter_options, null: false, foreign_key: true

      t.timestamps
    end
  end
end
