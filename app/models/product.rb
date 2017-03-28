class Product < ActiveRecord::Base

	has_many :warehouse_products
  has_many :warehouse_records
  has_many :system_records, as: :operatorable
	before_save :generate_product_no

	acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '冻结']
  	]

  def self.import file
    begin
      csv = file.open
      fields = csv.readline.split(',')
      csv.readlines.each do |line|
        info= line.chomp.utf8!.split(',')
        product = Product.new
        fields.each_with_index do |field, index|
          field = field.chomp
          product[field.to_sym] = info[index]
        end

        product = Product.create!(
          name: product.name,
          price: product.price,
          expiration_date: product.expiration_date,
          produced_date: product.produced_date,
          store_condition: product.store_condition,
          feature: product.feature,
          category: product.category,
          transport_condition: product.transport_condition
          )
        product.save!
      end
    rescue Exception => e
      return false
    end
  end

  	private
  	def generate_product_no
  		self.no = Time.now.strftime("%H%M%S") + rand(10).to_s
  	end
end