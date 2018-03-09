require 'resolv'

class Rrh < ApplicationRecord
  belongs_to :scenario

  validates :ip, presence: :true
  validates :model, presence: :true
  validates :scenario, :presence => true
  validates :version, presence: :true
  validates :latitude, presence: :true, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :longitude, :presence => true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
end
