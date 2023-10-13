# frozen_string_literal: true
 
module FalconCodelabs
  CONFIG = {
    aws: {
      account_id: ENV['ACCOUNT_ID'],
      credentials: {
        access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        session_token:     ENV['AWS_SESSION_TOKEN']
      },
      region: ENV['AWS_REGION'],
      bucket: {
        name: ENV['DEMO_APP_BUCKET_NAME'] || ENV['SERVICE_NAME'],
        server_side_encryption: {
          cipher: 'AES256'
        }
      }
    },
    falcon: {
      instance_id: ENV['INSTANCE_ID']
    }
  }.freeze
end

