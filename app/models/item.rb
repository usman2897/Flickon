class Item < ApplicationRecord
    has_many :orders
    has_many :carts
    has_many :item_properties
    belongs_to :category
    belongs_to :sub_category
    belongs_to :seller
    mount_uploader :image, ImageUploader

    def self.search(term)
        where('LOWER(item_name) LIKE :term', term: "%#{term.downcase}%")
    end
end
