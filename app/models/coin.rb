class Coin < ApplicationRecord
    belongs_to :mining_type #,optional:true

    validates :description, presence: true, length: { maximum: 25}
    validates :acronym, presence: true
    validates :url_image, presence: true
end
