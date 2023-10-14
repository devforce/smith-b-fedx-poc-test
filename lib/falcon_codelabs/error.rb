# frozen_string_literal: true

require 'English'

module FalconCodelabs
  module Errors
    class Error < StandardError
      attr_reader :original

      def initialize(msg, original = $ERROR_INFO)
        super(msg)
        @original = original
      end
    end

    class AwsConfiguration < Error; end
  end
end
