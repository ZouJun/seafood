class Staff < ActiveRecord::Base
  has_secure_password
  paginates_per 10

  validates :name, :address, :mobile, :role_id, presence: true
  validates :no, presence: true
  validates :mobile, :no, uniqueness: true
  validates :password, length: { in: 6..18 }, on: :create
  # validates :password, format:{with: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$/}
  validates :password, presence: true, on: :create

  belongs_to :department
  belongs_to :warehouse
  belongs_to :role
  belongs_to :province
  belongs_to :city
  belongs_to :district
  has_many :staff_transfers
  has_many :warehouse_records
  has_many :leaders
  has_many :system_records, as: :operatorable

  acts_as_enum :gender, :in => [
	    ['secert', 0, '保密'],
      ['male', 1, '男'],
      ['female', 2, '女']
  ]

  acts_as_enum :status, :in => [
      ['normal', 1, '正常'],
      ['disabled', -1, '冻结']
  ]

  def update_login_info(ip)
    self.update_attributes(current_sign_in_at: Time.now, current_sign_in_ip: ip, sign_in_count: self.sign_in_count + 1)
  end

  def update_login_out
    self.update_attributes(current_sign_out_at: Time.now, last_sign_in_at: self.current_sign_in_at, last_sign_in_ip: self.current_sign_in_ip)
  end

  class << self

    def authenticated(login, password)
      where("lower(no) LIKE ?", login.to_s.downcase).first.try(:authenticate, password)
    end

    def age
      {
        '25' => '25',
        '26' => '26',
        '27' => '27',
        '28' => '28',
        '29' => '29',
        '30' => '30',
        '31' => '31',
        '32' => '32',
        '33' => '33',
        '34' => '34',
        '35' => '35',
        '36' => '36',
        '37' => '37',
        '38' => '38',
        '39' => '39',
        '40' => '40',
        '41' => '41',
        '42' => '42',
        '43' => '43',
        '44' => '44',
      }
    end

    def years
      {
        '2017' => '2017',
        '2016' => '2016',
        '2015' => '2015',
        '2014' => '2014',
        '2013' => '2013',
        '2012' => '2012',
        '2011' => '2011',
        '2010' => '2010',
        '2009' => '2009',
        '2008' => '2008',

        '2007' => '2007',
        '2006' => '2006',
        '2005' => '2005',
        '2004' => '2004',
        '2003' => '2003',
        '2002' => '2002',
        '2001' => '2001',
        '2000' => '2000',
        '1999' => '1999',
        '1998' => '1998',


        '1997' => '1997',
        '1996' => '1996',
        '1995' => '1995',
        '1994' => '1994',
        '1993' => '1993',
        '1992' => '1992',
        '1991' => '1991',
        '1990' => '1990',
        '1989' => '1989',
        '1987' => '1987',
      }
    end

    def months
      {
        '01' => '01',
        '02' => '02',
        '03' => '03',
        '04' => '04',
        '05' => '05',
        '06' => '06',
        '07' => '07',
        '08' => '08',
        '09' => '09',
        '10' => '10',
        '11' => '11',
        '12' => '12',
      }
    end

    def days
      {
        '01' => '01',
        '02' => '02',
        '03' => '03',
        '04' => '04',
        '05' => '05',
        '06' => '06',
        '07' => '07',
        '08' => '08',
        '09' => '09',
        '10' => '10',
        '11' => '11',
        '12' => '12',
        '13' => '13',
        '14' => '14',
        '15' => '15',
        '16' => '16',
        '17' => '17',
        '18' => '18',
        '19' => '19',
        '20' => '20',
        '21' => '21',
        '22' => '22',
        '23' => '23',
        '24' => '24',
        '25' => '25',
        '26' => '26',
        '27' => '27',
        '28' => '28',
        '29' => '29',
        '30' => '30',
        '31' => '31',
      }
    end

    def import file
      begin
        csv = file.open
        fields = csv.readline.split(',')
        csv.readlines.each do |line|
          info= line.chomp.utf8!.split(',')
          staff = Staff.new
          fields.each_with_index do |field, index|
            field = field.chomp
            staff[field.to_sym] = info[index]
          end
          staff_no = Time.now.strftime("%H%M%S") + rand(10).to_s
          role = Role.where(name: staff.role).first
          department = Department.where(name: staff.department).first
          warehouse = Warehouse.where(name: staff.warehouse).first
          # province = Province.where(name: staff.province).first
          # city = City.where(name: staff.province).first
          # district = District.where(name: staff.province).first
          if Staff.where(mobile: staff.mobile).first.present?
            next
          else
            staff = Staff.create!(
              name: staff.name,
              role_id: role.try(:id) || Role.last.id,
              no: staff_no,
              mobile: staff.mobile,
              gender: staff.gender,
              years: staff.years,
              months: staff.months,
              days: staff.days,
              age: staff.age,
              # province_id: province.id,
              # city_id: city.id,
              # district_id: district.id,
              address: staff.address,
              email: staff.email,
              description: staff.description,
              department_id: department.try(:id) || 1,
              warehouse_id: warehouse.try(:id) || nil
              )
            staff.save!
          end
        end
      rescue Exception => e
        return false
      end
    end
  end

end