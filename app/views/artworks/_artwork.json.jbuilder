json.extract! artwork, :id, :name, :img_link, :value, :is_public, :created_at, :updated_at
json.url artwork_url(artwork, format: :json)
