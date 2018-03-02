class Alarm < ApplicationRecord
  belongs_to :vnf
  ##belongs_to :network_service

  validates :name, presence: :true
  #validates :description, presence: :false
  #validates :vnf, presence: :false
  #validates :network_service, presence: :false
  validate :vnf_or_network_service_presence

  def vnf_or_network_service_presence
    if vnf.empty? and network_service.empty?
        errors.add(:base, "Alarm must contain a vnf or a network service")
    end
  end
end
