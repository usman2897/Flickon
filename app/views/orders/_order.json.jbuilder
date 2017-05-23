json.extract! order, :id, :order_id, :user_id, :item_id, :ordered_quantity, :total_price, :created_at, :updated_at
json.url order_url(order, format: :json)
