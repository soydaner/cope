provider "aws" {
  region = var.region
}

module "lambda_retrieve"{
  source = "../../modules/lambda_retrieve"

  project_code = var.project_code
  env_name = var.env_name
 
  bucket-etl-in-arn = module.s3.etl-in-arn 
  bucket-etl-in-bucket = module.s3.etl-in-bucket  
}

module "s3"{
  source = "../../modules/s3"

  project_code = var.project_code
  env_name = var.env_name
}

module "eventbridge"{
  source = "../../modules/eventbridge"

  project_code = var.project_code
  env_name = var.env_name
  lambda_arn = module.lambda_retrieve.lambda-retrieve-arn
  lambda_function_name = "${var.project_code}-${var.env_name}-weather_retrieve"
  
}

module "lambda_etl"{
  source = "../../modules/lambda_etl"

  project_code = var.project_code
  env_name = var.env_name
 

  bucket-etl-in-id = module.s3.etl-in-id
  bucket-etl-in-arn = module.s3.etl-in-arn
  bucket-etl-out-bucket = module.s3.etl-out-bucket
  bucket-etl-out-arn = module.s3.etl-out-arn
}
