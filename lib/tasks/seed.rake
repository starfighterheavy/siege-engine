namespace :seed do
  require 'dotenv'
  require 'open-uri'

  Dotenv.load('.env.development', '.env')

  def get_access_key
    AccessKey.find_or_create_by!(access_key_id: ENV['SE_ACCESS_KEY_ID'])
  end

  def get_siege_template
    JSON.parse(open(ENV['SIEGE_TEMPLATE_URL']).read)
  end

  desc "create AccessKey from ENV"
  task access_key: :environment do
    key = get_access_key
    key.update_attributes(access_key_id: ENV['SE_ACCESS_KEY_ID'], secret_access_key: ENV['SE_SECRET_ACCESS_KEY'])
  end

  task siege: :environment do
    key = get_access_key
    template = get_siege_template
    puts template
  end
end
