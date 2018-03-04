class Pop < ApplicationRecord
  has_many :vnfs, dependent: :delete_all

  validates :name, presence: :true
  validates :ip, presence: :true
  validates :instance, presence: :true
  validates_inclusion_of :instance, :in =>["OpenStack","AWS","GCE"]
end
