#!/usr/bin/ruby
require 'cloudflair'
require 'faraday'
require 'resolv'

$stdout.sync = true

email = ENV['CF_EMAIL']
key = ENV['CF_KEY']
subdomain = ENV['SUBDOMAIN']
zone_name = ENV['ZONE_NAME']
run_every = (ENV['RUN_EVERY'] || 3600).to_i

fqdn = if subdomain.nil? || subdomain.empty?
         zone_name
       else
         "#{subdomain}.#{zone_name}"
       end

Cloudflair.configure do |config|
  config.cloudflare.auth.key = key
  config.cloudflare.auth.email = email
end

loop do
  uplink_ip = Faraday.get('http://checkip.amazonaws.com').body.strip
  begin
    dns_ip = Resolv.getaddress(fqdn)
    dns_exists = true
  rescue
    dns_ip = 'creating'
    dns_exists = false
  end

  puts "Uplink: #{uplink_ip}"
  puts "DNS: #{dns_ip}"

  unless uplink_ip == dns_ip
    z = Cloudflair.zones(name: zone_name).first
    r = Cloudflair.zone(z.zone_id).dns_records(name: fqdn).first if dns_exists == true

    opts = {
      name: fqdn,
      type: 'A',
      content: uplink_ip,
      ttl: 1,
      proxied: false,
    }.to_json

    begin
      if dns_exists == true
        Faraday.new(url: Cloudflair.config.cloudflare.api_base_url).put do |f|
          f.url "/client/v4/zones/#{z.zone_id}/dns_records/#{r.record_id}"
          f.headers['X-Auth-Key'] = Cloudflair.config.cloudflare.auth.key
          f.headers['X-Auth-Email'] = Cloudflair.config.cloudflare.auth.email
          f.headers['Content-Type'] = 'application/json'
          f.body = opts
        end
      else
        Cloudflair.zone(z.zone_id).new_dns_record(opts)
      end
      puts 'Updated successfully'
    rescue
      puts 'Failed to update!'
    end
  end
  puts
  sleep run_every
end
