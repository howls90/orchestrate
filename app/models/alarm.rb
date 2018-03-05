class Alarm < ApplicationRecord
  belongs_to :vnf

  validates :name, presence: :true
end
