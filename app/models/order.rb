class Order < ApplicationRecord
    
    has_many :order_tracks
    belongs_to :user
    belongs_to :item

    id = nil
  after_save {id = self.id}
end


