class InitTable < ActiveRecord::Migration
  def change
    create_table 'staffs' do |t|
      t.string :name
      t.string :password_digest
      t.string :no, :null => false
      t.string :mobile, :null => false
      t.integer :gender, :null => false, :default => 1
      t.integer :years
      t.integer :months
      t.integer :days
      t.integer :age
      t.string :qq
      t.string :weixin
      t.integer :province_id, :null => false, :default => 9
      t.integer :city_id, :null => false, :default => 73
      t.integer :district_id, :null => false, :default => 702
      t.string :address, :null => false
      t.string :email
      t.string :description
      t.integer :sign_in_count, :null => false, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :current_sign_out_at
      t.string :current_sign_in_ip
      t.datetime :last_sign_in_at
      t.string :last_sign_in_ip
      t.integer :department_id
      t.integer :warehouse_id
      t.integer :role_id, :null => false
      t.integer :status, :null => false, :default => 1

      t.timestamps
    end

    create_table 'departments' do |t|
      t.string :name, :null => false
      t.string :description, :null => false
      t.integer :sort, :null => false, :default => 1
      t.integer :status, :null => false, :default => 1

      t.timestamps
    end

    create_table 'roles' do |t|
      t.string :name, :null => false
      t.integer :sort, :null => false, :default => 1
      t.string :description, :null => false
      t.integer :status, :null => false, :default => 1

      t.timestamps
    end

    create_table 'role_permission_maps' do |t|
      t.integer :permission_id, :null => false
      t.integer :role_id, :null => false

      t.timestamps
    end

    create_table 'permissions' do |t|
      t.string :name, :null => false
      t.string :description
      t.integer :status, :null => false, :default => 1
      t.integer :sort, :null => false, :default => 1

      t.timestamps
    end

    create_table 'staff_transfers' do |t|
      t.integer :staff_id, :null => false
      t.integer :is_admin, :null => false, :default => 0
      t.integer :is_department, :null => false, :default => 0
      t.integer :is_warehouse, :null => false, :default => 0
      t.integer :before_department_id
      t.integer :department_id
      t.integer :before_warehouse_id
      t.integer :warehouse_id
      t.string :description
      t.integer :operator_id, :null => false
      t.string :operator_type, :null => false

      t.timestamps
    end

    create_table 'warehouses' do |t|
      t.string :name, :null => false
      t.integer :size, :null => false, :default => 1
      t.integer :scale
      t.integer :province_id, :null => false, :default => 9
      t.integer :city_id, :null => false, :default => 73
      t.integer :district_id, :null => false, :default => 702
      t.string :address, :null => false
      t.string :description
      t.integer :status, :null => false, :default => 1

      t.timestamps
    end

    create_table 'products' do |t|
      t.string :name, :null => false
      t.string :no, :null => false
      t.decimal :price, :null => false, :precision => 10, :scale => 2, :default => 0.0
      t.datetime :expiration_date, :null => false
      t.integer :produced_date, :null => false
      t.string :store_condition, :null => false
      t.string :feature
      t.string :category
      t.string :transport_condition
      t.integer :status, :null => false, :default => 1

      t.timestamps
    end

    create_table 'warehouse_records' do |t|
      t.integer :product_id, :null => false
      t.integer :warehouse_id, :null => false
      t.integer :staff_id, :null => false
      t.integer :is_admin, :null => false, :default => 0
      t.integer :qty, :null => false, :default => 0
      t.decimal :price, :null => false, :precision => 10, :scale => 2, :default => 0.0
      t.integer :record_type, :null => false, :default => 1

      t.timestamps
    end

    create_table 'warehouse_products' do |t|
      t.integer :product_id, :null => false
      t.integer :warehouse_id, :null => false
      t.integer :qty, :null => false, :default => 0
      t.decimal :price, :null => false, :precision => 10, :scale => 2, :default => 0.0

      t.timestamps
    end

    create_table 'system_records' do |t|
      t.string :operatorable_id, :null => false
      t.string :operatorable_type, :null => false
      t.string :action, :null => false
      t.integer :operator_id, :null => false
      t.string :operator_type, :null => false

      t.timestamps
    end

    create_table 'provinces' do |t|
      t.string :name
      t.string :pinyin
      t.integer :sort
      
      t.timestamps
    end

    create_table 'cities' do |t|
      t.string :name
      t.string :pinyin
      t.integer :sort
      t.integer :province_id

      t.timestamps
    end

    create_table 'districts' do |t|
      t.string :name
      t.string :pinyin
      t.integer :sort
      t.integer :city_id

      t.timestamps
    end

  end
end
