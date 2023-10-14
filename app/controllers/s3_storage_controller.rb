# frozen_string_literal: true

require 'falcon_codelabs/error'
require 'falcon_codelabs/gateways/aws'

class S3StorageController < ApplicationController
  rescue_from FalconCodelabs::Errors::AwsConfiguration, with: :aws_configuration_error

  def index
    @result = s3.list_objects

    respond_to do |format|
      format.html
      format.json { render json: @result }
    end
  end

  def create
    @result = s3.put_object(key: file.original_filename, body: file.tempfile)

    render json: @result
  end

  private

  # :nocov:
  def s3
    FalconCodelabs::Aws::S3.new
  end
  # :nocov:

  def file
    params[:data]
  end

  def aws_configuration_error(exception)
    render plain: exception.inspect, status: 502
  end
end
