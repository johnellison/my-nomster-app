class Place < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  after_validation :geocode
  validates :name, :presence => 'true', :length => { :minimum => 2 }
  validates :description, :presence => 'true'
  validates :address, :presence => 'true'
end
