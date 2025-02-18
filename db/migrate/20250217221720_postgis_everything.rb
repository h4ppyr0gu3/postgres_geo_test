class PostgisEverything < ActiveRecord::Migration[7.2]
  def change
    enable_extension "postgis"  # Enable PostGIS extension

    create_table :postgis_points do |t|
      t.string :name
      t.string :region
      t.st_point :geom, geographic: true, null: false # PostGIS geometry column

      t.timestamps
    end

    # Create spatial index (GiST index recommended for point data)
    add_index :postgis_points, :geom, using: :gist
  end
end
