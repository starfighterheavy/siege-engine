namespace :seed do
  desc "create AccessKey from ENV"
  task access_key: :environment do
    require 'dotenv'
    Dotenv.load('.env.development', '.env')

    key = AccessKey.find_or_create_by!(access_key_id: ENV['SE_ACCESS_KEY_ID'])
    key.update_attributes(access_key_id: ENV['SE_ACCESS_KEY_ID'], secret_access_key: ENV['SE_SECRET_ACCESS_KEY'])
  end
end
