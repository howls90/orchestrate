class Script < ApplicationRecord
  #belongs_to :vnf
  belongs_to :user

  validates :name, presence: :true
  validates :provider, presence: :true
  validates :configuration, presence: :true
end
