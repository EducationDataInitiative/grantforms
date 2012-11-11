class GrantApplication < ActiveRecord::Base
  belongs_to :grant
  belongs_to :organization
  belongs_to :user
  attr_accessible :data, :grant_id, :organization_id, :user_id, :organization_attributes
  validates_presence_of :grant, :organization, :user
  accepts_nested_attributes_for :organization
  serialize :data
  
  def submit_to_mygov
    sf424_data = {}
    sf424_data.merge!(organization_name: self.organization.name, 
                      organization_ein: self.organization.ein, 
                      organization_duns: self.organization.duns,
                      organization_address: self.organization.address,
                      organization_address2: self.organization.address2,
                      organization_city: self.organization.city,
                      organization_county: (self.data[:organization_county] || nil),
                      organization_state: self.organization.state,
                      organization_province: (self.data[:organization_province] || nil),
                      organization_country: self.organization.country,
                      organization_zip: self.organization.zip)
    sf424_data.merge!(self.data)
    i3_data = {}
    self.user.submit_forms({:sf_424 => {:form_number => "sf-424", :data => sf424_data},
                            :i3 => {:form_number => "i3", :data => i3_data}})
  end
end
