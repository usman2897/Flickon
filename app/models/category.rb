class Category < ApplicationRecord
    has_many :items
    has_many :sub_categoris
end
