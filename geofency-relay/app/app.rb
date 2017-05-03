require 'sinatra/base'
require 'net/http'

class WebApp < Sinatra::Base
  get '/' do
    halt 200
  end

  post '/*' do
    uri = URI("https://connected2.homeseer.com#{request.path}?#{request.query_string}")
    Net::HTTP.get(uri)
  end
end
