class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.string :domain, :null => false, :default => ""
      t.string :smtp_server, :null => false, :default => ""
      t.boolean :email_notifications, :null => false, :default => false
      t.boolean :email_verifications, :null => false, :default => false

      t.timestamps
    end
    Preference.create!
  end

  def self.down
    drop_table :preferences
  end
end
