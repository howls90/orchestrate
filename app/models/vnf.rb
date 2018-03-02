class Vnf < ApplicationRecord
    belongs_to :network_service
    belongs_to :pop
    has_many :scripts, dependent: :delete_all
    has_many :alarms

    validates :name, presence: :true
    validates :description, presence: :false
    validates :command, presence: :false
    validates :cpu, presence: :true
    validates :ram, presence: :true
    validates :disc, presence: :true
    validates :url_server, presence: :true
    validates_inclusion_of :status, presence: :true, :in =>["Running","Shut Down","Building","Deleting"]
    validates :ns, presence: :true
    validates :pop, presence: :true    
end
