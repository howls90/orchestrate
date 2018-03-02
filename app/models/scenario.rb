class Scenario < ApplicationRecord
    has_many :rrhs, dependent: :destroy

    validates :name, presence: :true
end
