require 'json'
require 'uri'

path = ARGV[0]

res_str = `curl -X POST --header 'Accept: application/json' $HOST/uploads`
res = JSON.parse(res_str)
presigned_url = URI.parse(res['presigned_url']).to_s

command = "curl -X PUT --header 'Content-Type: image/jpeg' --data-binary '@#{path}' '#{presigned_url}'"
puts command
system(command)

command = <<-EOS
curl -X POST \
  --header 'Content-Type: application/json' \
  --header 'Accept: application/json' \
  --data '{"timestamp": #{res['timestamp']}}' \
  $HOST/images
EOS

puts command
system(command)