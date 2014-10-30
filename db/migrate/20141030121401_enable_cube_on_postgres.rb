class EnableCubeOnPostgres < ActiveRecord::Migration
  def change
    enable_extension 'cube'
  end
end
