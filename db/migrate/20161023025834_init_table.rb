class InitTable < ActiveRecord::Migration
  def change
    create_table 'orders' do |t|
      t.string :order_no
      t.date :booking_at
      t.string :detail
      t.string :username
      t.string :mobile
      t.string :address
      t.string :description
      t.integer :admin_allocation_type
      t.integer :agent_allocation_type
      t.string :order_status
      t.integer :admin_status, :default => 1
      t.integer :agent_status, :default => 1
      t.integer :category_id
      t.integer :user_id
      t.integer :agent_id
      t.integer :dispatcher_id

      t.timestamps
    end

    create_table 'categories' do |t|
      t.string :name, :null => false
      t.integer :sort
      t.string :description
      t.integer :category_type, :default => 1
      t.integer :status, :default => 1

      t.timestamps
    end

    create_table 'comments' do |t|
      t.integer :star
      t.string :description
      t.integer :order_id
      t.integer :status, :default => 1

      t.timestamps
    end

    create_table 'agents' do |t|
      t.string :name
      t.string :login
      t.string :password_digest
      t.string :mobile
      t.string :email
      t.string :tel
      t.string :address
      t.integer :proxy_type
      t.integer :province_id, :default => 9, :null => false
      t.integer :city_id, :default => 73, :null => false
      t.integer :district_id, :default => 702, :null => false
      t.string :description
      t.integer :status, :default => 1

      t.timestamps
    end

    create_table 'accounts' do |t|
      t.string :name
      t.string :login
      t.string :password_digest
      t.string :mobile
      t.string :email
      t.string :tel
      t.string :address
      t.integer :province_id, :default => 9, :null => false
      t.integer :city_id, :default => 73, :null => false
      t.integer :district_id, :default => 702, :null => false
      t.string :description
      t.integer :status, :default => 1

      t.timestamps
    end

    create_table 'dispatchers' do |t|
      t.string :name
      t.string :login
      t.string :password_digest
      t.string :mobile
      t.string :email
      t.string :tel
      t.string :address
      t.integer :province_id, :default => 9, :null => false
      t.integer :city_id, :default => 73, :null => false
      t.integer :district_id, :default => 702, :null => false
      t.string :description
      t.integer :status, :default => 1
      t.integer :agent_id

      t.timestamps
    end

    create_table 'user_addresses' do |t|
      t.string :name
      t.string :mobile
      t.string :address
      t.boolean :is_default, :default => false
      t.string :description
      t.integer :status, :default => 1
      t.integer :user_id

      t.timestamps
    end
  end
end
