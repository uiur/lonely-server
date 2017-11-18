json.partial! "images/image", image: @image
json.set! :presigned_url, @image.url
