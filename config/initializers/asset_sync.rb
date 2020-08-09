AssetSync.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_directory = Rails.application.credentials.aws[:s3_bucket]
  config.aws_access_key_id = Rails.application.credentials.aws[:access_key_id]
  config.aws_secret_access_key = Rails.application.credentials.aws[:secret_access_key]
  config.manifest = true
  config.fog_region = 'ap-northeast-1'
end
