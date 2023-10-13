# frozen_string_literal: true

require 'falcon_codelabs/gateways/aws'

module FalconCodelabs
  module Aws
    RSpec.describe S3 do
      let(:client) { double('S3') }

      subject do
        described_class.new(client: client)
      end

      specify do
        expect(subject).to respond_to(:default_bucket)
        expect(subject).to respond_to(:put_object)
        expect(subject).to respond_to(:get_object)
        expect(subject).to respond_to(:list_objects)
        expect(subject).to respond_to(:list_buckets)
      end
    end
  end
end
