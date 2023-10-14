require 'rspec/rails'
require 'spec_helper'

module FalconCodelabs
  RSpec.describe HomeController, type: :controller do
    specify '/' do
      get :index

      expect(response.status).to eq(200)
    end
  end
end
