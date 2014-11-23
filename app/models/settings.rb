class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

   def app_url
    "#{domain.protocol}#{domain.host}#{domain.port}"
  end
end