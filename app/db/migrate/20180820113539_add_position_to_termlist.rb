class AddPositionToTermlist < ActiveRecord::Migration[5.2]
  def change
    add_column :termlists, :position, :integer
  end
end
