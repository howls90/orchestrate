class Script < ApplicationRecord
  belongs_to :vnf

  validates :name, presence: :true
  validates :provider, presence: :true
  validates :configuration, presence: :true
end
