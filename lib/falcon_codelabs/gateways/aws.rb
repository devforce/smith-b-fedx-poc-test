# frozen_string_literal: true

require 'digest'

require 'aws-sdk-s3'
require 'aws-sdk-core'

require 'falcon_codelabs/config'

module FalconCodelabs
  module Aws
    class S3
      def initialize(client: nil)
        @client = client || handle_exceptions {
          ::Aws::S3::Client.new(region:, credentials:)
        }
      end

      def default_bucket
        "#{bucket_prefix}-#{bucket_suffix}"
      end

      def put_object(key:, body:, bucket: default_bucket, server_side_encryption: default_cipher)
        handle_exceptions {
          client.put_object({ key:, body:, bucket:, server_side_encryption: })
        }
      end

      def get_object(key:, bucket: default_bucket)
        handle_exceptions {
          client.get_object(key:, bucket:)
        }
      end

      def list_objects(bucket: default_bucket, max_keys: 5)
        handle_exceptions {
          client.list_objects(bucket:, max_keys:).contents
        }
      end

      def list_buckets
        handle_exceptions {
          client.list_buckets.buckets.map(&:name)
        }
      end

      private

      attr_reader :client

      def credentials
        ::Aws::Credentials.new(*CONFIG.dig(:aws, :credentials).values)
      end

      def region
        CONFIG.dig(:aws, :region)
      end

      def default_cipher
        CONFIG.dig(:aws, :bucket, :server_side_encryption, :cipher)
      end

      def bucket_prefix
        CONFIG.dig(:aws, :bucket, :name)
      end

      # https://git.soma.salesforce.com/falcon-addons/s3-addon/blob/master/README.md
      def bucket_suffix
        Digest::SHA256.hexdigest("#{CONFIG.dig(:aws, :account_id)}-#{CONFIG.dig(:falcon, :instance_id)}")[0, 20]
      end

      def handle_exceptions
        yield
      rescue ::Aws::Errors::MissingCredentialsError,
             ::Aws::Errors::MissingRegionError,
             ::Aws::S3::Errors::ExpiredToken,
             ::Aws::S3::Errors::AccessDenied,
             ::Aws::S3::Errors::InvalidAccessKeyId => e

        raise FalconCodelabs::Errors::AwsConfiguration, e.message
      end
    end
  end
end
