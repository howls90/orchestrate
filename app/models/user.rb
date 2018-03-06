class User < ApplicationRecord
  has_secure_password

  has_many :network_services
  has_many :vnfs
  has_many :alarms
  has_many :scripts
end
