# app/services/api_client.rb
require 'faraday'
require 'circuitbox'

class ApiClient
  CIRCUIT_TIMEOUT = 2 # seconds
  CIRCUIT_THRESHOLD = 3 # failures
  CIRCUIT_INTERVAL = 60 # seconds
  def initialize(service_base_url)
    @service_name = URI.parse(service_base_url).host
    @circuit = Circuitbox.circuit(@service_name, {
      timeout: CIRCUIT_TIMEOUT,
      volume_threshold: CIRCUIT_THRESHOLD,
      sleep_window: CIRCUIT_INTERVAL
    })

    @conn = Faraday.new(
      url: service_base_url,
      headers: { 'Content-Type' => 'application/json' }
    ) do |faraday|
      faraday.request :json
      faraday.response :json
      faraday.response :raise_error # This will raise exceptions for 4xx/5xx responses
      faraday.adapter Faraday.default_adapter
      faraday.options.timeout = 5 # 5 seconds timeout
      faraday.options.open_timeout = 2 # 2 seconds connection timeout
    end
  end

  def get(path, params = {})
    @circuit.run do
      response = @conn.get(path) do |req|
        req.params = params
        req.headers['Authorization'] = "Bearer #{JwtService.service_token}"
      end
      handle_response(response)
    end
  rescue Circuitbox::Error => e
    { error: 'Service unavailable', message: e.message, service: @service_name }
  end

  private

  def handle_response(response)
    case response.status
    when 200..299
      response.body
    when 401
      raise "Unauthorized request"
    when 404
      raise "Resource not found"
    else
      raise "API request failed with status #{response.status}"
    end
  end
end