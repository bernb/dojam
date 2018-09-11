class AddTermlistPathUniqueKeyConstrainOnTermlistPath < ActiveRecord::Migration[5.2]
  def change
		add_index :termlist_paths, [:termlist_id, :path_id], unique: true
  end
end
