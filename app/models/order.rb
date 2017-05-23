class Order < ApplicationRecord
    
    has_many :order_tracks
    belongs_to :user
    belongs_to :item
    self.primary_keys = :order_id,:item_id
    
end


