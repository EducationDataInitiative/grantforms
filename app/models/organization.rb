class Organization < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :address2, :city, :country, :department_name, :division_name, :duns, :ein, :name, :province, :state, :zip, :user_id
  validates_presence_of :name, :ein, :duns
  
  def to_param
    self.duns
  end
end
