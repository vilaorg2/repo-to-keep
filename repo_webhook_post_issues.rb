require 'sinatra'
require 'json'
require 'rubygems'
require 'net/http'
require 'uri'
require 'OpenSSL'

post '/payload' do
  push =JSON.parse(request.body.read)
  puts "Repository webhook is triggered: #{push.inspect}"

#read Access Token from File
  mode = "r+"
  file = File.open("./GitHub.json", mode)
  fileContent = file.read
  data_hash = JSON.parse(fileContent)

  uri = URI.parse("https://api.github.com/repos/VictoriaOrg/repo-to-keep/issues")
  uri.query = URI.encode_www_form(access_token:data_hash["access_token"])

  http = Net::HTTP.new(uri.host, uri.port)

  http.use_ssl = (uri.scheme == 'https')
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Post.new(uri.request_uri)

# Specify parameters for Issues
  request.body = {
    title: 'Verify deleted Repo', body: '@VictoriaLam1: WARNING! A repository is being deleted. Please verify.', assignee: 'VictoriaLam1'
  }.to_json

  response = http.request(request)
  response2 = JSON.parse(response.body)

  puts response2
end
