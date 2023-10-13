module "s3-addon" {
  source      = "registry.iac.commercial1.sfdc.cl/falcon-addons/s3-addon/falcon"
  version     = "~> 0.1.8"
  id          = "s3-addon"
  bucket_name = "smith-b-fedx-poc-test"
}
