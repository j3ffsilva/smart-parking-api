FactoryGirl.define do
  factory :api_client, class: APIClient do
    name 'Some client'
    token SecureRandom.base64.tr('+/=', 'Qrt')
  end
end
