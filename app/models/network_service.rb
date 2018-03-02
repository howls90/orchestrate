class NetworkService < ApplicationRecord
    has_many :vnfs, dependent: :delete_all
    #has_many :alarms, dependent: :delete_all

    validates :name, presence: :true
    #validates :description, presence: :false
end
