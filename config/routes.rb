# frozen_string_literal: true

PROBE_RESPONSE = Proc.new { [200, {'Content-Type' => 'text/plain'}, ['ok']] }

Rails.application.routes.draw do
  get  '/',       to: 'home#index'
  get  '/list',   to: 's3_storage#index'
  post '/upload', to: 's3_storage#create'

  # On port 15372, K8s will run health checks at /manage/health and /manage/ready
  # If the health check fails K8s will specify that the Docker container
  # running inside your pod has gone bad.
  get '/manage/:probe', to: PROBE_RESPONSE, probe: /(health|ready)/
end
