class SubCategory < ApplicationRecord
    has_many :items
    belongs_to :category
end
