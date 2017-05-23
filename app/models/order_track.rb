class OrderTrack < ApplicationRecord
    self.primary_keys = 'order_id', 'status'
    belongs_to :order
end
