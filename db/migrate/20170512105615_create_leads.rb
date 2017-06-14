class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :location
      t.string :email
      t.text :comment
      t.references :user, index: true, foreign_key: true
      t.boolean :processed

      t.timestamps null: false
    end
  end
end
