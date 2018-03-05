class NetworkService < ApplicationRecord
    has_many :vnfs
    validates :name, presence: :true
end
