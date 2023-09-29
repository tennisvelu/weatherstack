class CreateCachedForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :cached_forecasts do |t|
      t.string :zip_code
      t.text :data
      t.datetime :expires_at

      t.timestamps
    end
  end
end
