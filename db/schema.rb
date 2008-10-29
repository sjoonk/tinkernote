# I will use auto_migrations

ActiveRecord::Schema.define do

  create_table :pages do |t|
    t.column :title, :string
    t.column :body, :text
    t.column :user_id, :integer
    t.timestamps
  end
  
  create_table :titles do |t|
    t.string :text
  end
  
  create_table :pages_titles, :id => false do |t|
    t.integer :page_id, :title_id
  end

  # for simply versioned
  create_table :versions do |t|
    t.integer   :versionable_id
    t.string    :versionable_type
    t.integer   :number
    t.text      :yaml
    t.datetime  :created_at
  end
  add_index :versions, [:versionable_id, :versionable_type]

  create_table "users", :force => true do |t|
    t.column :login,                     :string, :limit => 40
    t.column :name,                      :string, :limit => 100, :default => '', :null => true
    t.column :email,                     :string, :limit => 100
    t.column :crypted_password,          :string, :limit => 40
    t.column :salt,                      :string, :limit => 40
    t.column :created_at,                :datetime
    t.column :updated_at,                :datetime
    t.column :remember_token,            :string, :limit => 40
    t.column :remember_token_expires_at, :datetime
  end
  add_index :users, :login, :unique => true

end
