json.array!(@imgs) do |img|
    json.image_id img.id
    json.url img.image(:large)
    json.icon img.icon
end