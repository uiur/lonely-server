json.partial! "images/image", image: @image
json.set! :presigned_url, @image.s3_object.presigned_url(:get)
