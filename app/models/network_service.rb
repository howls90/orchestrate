class NetworkService < ApplicationRecord
    has_many :vnfs
    # has_many :alarms, dependent: :delete_all
    validates :name, presence: :true
end
