class NetworkService < ApplicationRecord
    has_many :vnfs
    belongs_to :user
    validates :name, presence: :true
end
