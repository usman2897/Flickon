json.extract! item, :id, :item_name, :category_id, :sub_category_id, :quantity, :price, :description, :seller_id,:image_url
json.url item_url(item, format: :json)
