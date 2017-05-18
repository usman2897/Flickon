json.extract! item, :id, :item_name, :category_id, :sub_category_id, :quantity, :price, :description, :seller_id, :created_at, :updated_at
json.url item_url(item, format: :json)
