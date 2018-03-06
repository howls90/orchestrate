class Vnf < ApplicationRecord
    belongs_to :network_service
    belongs_to :pop
    has_many :scripts, dependent: :delete_all
    has_many :alarms, dependent: :delete_all
    belongs_to :user

    validates :name, presence: :true
    validates :cores, presence: :true
    validates :ram, presence: :true
    validates :disc, presence: :true
    validates_inclusion_of :status, :in =>["Running","Shut Down","Building","Deleting"]  
end
