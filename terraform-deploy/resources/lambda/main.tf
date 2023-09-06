module "accessors" {
  source = "./accessors"
  stage = var.stage
}

module "managers" {
  source = "./managers"
  stage = var.stage
}

# module "engines"{
#   source = "./engines"   
#   stage = var.stage
# }