require 'json'
require 'uri'

path = ARGV[0]

res_str = `curl -X POST --header 'Accept: application/json' $HOST/images.json`
encoded_presigned_url = JSON.parse(res_str)['presigned_url']
presigned_url = URI.parse(encoded_presigned_url).to_s

command = "curl -X PUT --header 'Content-Type: image/jpeg' --data-binary '@#{path}' '#{presigned_url}'"
puts command

system(command)