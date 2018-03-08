class Alarm < ApplicationRecord
  belongs_to :vnf
  belongs_to :user
  
  validates :name, presence: :true
end
