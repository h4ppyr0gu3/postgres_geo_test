class AddEverything < ActiveRecord::Migration[7.2]
  def change
    enable_extension "cube"
    enable_extension "earthdistance"

    create_table :points do |t|
      t.string :name
      t.string :region
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end

    execute("CREATE INDEX index_points_on_latitude_and_longitude ON points USING GIST (ll_to_earth(latitude, longitude))")
  end
end
