terraform {
  required_providers {
    falcon = {
      source = "registry.iac.commercial1.sfdc.cl/falcon-addons/falcon"
      version = ">= 1.0"
    }
  }
}

provider "falcon" { 
    service_name = "smith-b-fedx-poc-test"
    service_team = "trailhead"
}

data "falcon_service" "current" {}

locals {
  team = data.falcon_service.current.team
  name = data.falcon_service.current.name
}
