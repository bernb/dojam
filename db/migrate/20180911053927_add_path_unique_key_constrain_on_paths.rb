class AddPathUniqueKeyConstrainOnPaths < ActiveRecord::Migration[5.2]
  def change
		add_index :paths, :path, unique: true
  end
end
