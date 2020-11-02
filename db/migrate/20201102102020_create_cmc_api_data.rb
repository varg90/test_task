class CreateCmcApiData < ActiveRecord::Migration[6.0]
  def change
    create_table :cmc_api_data do |t|
      t.string :endpoint
      t.jsonb :data, default: '{}'

      t.timestamps
    end
  end
end
