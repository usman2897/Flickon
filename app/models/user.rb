class User < ApplicationRecord
    has_many :feedbacks
    has_many :orders
    has_many :carts
    has_secure_password
    
end
