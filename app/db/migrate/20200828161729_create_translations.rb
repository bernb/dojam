class CreateTranslations < ActiveRecord::Migration[6.0]
  def self.up
    create_table :translations do |t|
      t.string :locale
      t.string :key
      t.text   :value
      t.text   :interpolations
      t.boolean :is_proc, :default => false
      t.boolean :is_termlist, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :translations
  end
end
