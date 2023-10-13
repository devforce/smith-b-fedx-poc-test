require 'rspec/rails'
require 'spec_helper'

module FalconCodelabs
  RSpec.describe S3StorageController, type: :controller do
    before do
      allow(subject).to receive(:s3).and_return(s3_client)
    end

    let(:s3_client) {
      instance_double(
        'FalconCodelabs::Aws::S3',:list_objects => [], :put_object => {}
      )
    }

    describe 'S3 client is not configured properly' do
      specify '/' do
        allow(s3_client).to receive(:list_objects).and_raise(Errors::AwsConfiguration, 'error')

        get :index

        expect(response.status).to eq(502)
      end
    end

    describe 'S3 client is configured' do
      specify 'index' do
        request.headers['Accept'] = 'application/json'

        get :index

        expect(response.status).to eq(200)
      end

      describe 'create' do
        let(:file) {
          fixture_file_upload('spec/fixtures/metrics.txt', 'text/plain')
        }

        specify do
          request.headers['Accept'] = 'text/html'

          post :create, params: { data: file }

          expect(response.status).to eq(200)
        end
      end
    end
  end
end
