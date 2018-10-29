class Rack::Attack
 
 Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
 
 # Allow all local traffic
 
#  safelist('allow-localhost') do |req|
 
#    '127.0.0.1' == req.ip || Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address) == req.ip
 
#  end
 
 # Allow an IP address to make 5 requests every 10 seconds
 
 throttle('req/ip', limit: 5, period: 10) do |req|
 
   req.ip
 
 end
 
end