class MiningType < ApplicationRecord
    has_many :coins

    validates :description, presence: true, length: { maximum: 25}
    validates :acronym, presence: true
end
