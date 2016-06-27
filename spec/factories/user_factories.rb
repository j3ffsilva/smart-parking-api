FactoryGirl.define do
  factory :user do
    provider               'email'
    uid                    'testemail2@mydomain.com'
    password               'sdfasfasd'
    encrypted_password     ''
    reset_password_token   ''
    reset_password_sent_at DateTime.current
    remember_created_at    DateTime.current
    sign_in_count          0
    current_sign_in_at     DateTime.current
    last_sign_in_at        DateTime.current
    current_sign_in_ip     ''
    last_sign_in_ip        ''
    confirmation_token     ''
    confirmed_at           DateTime.current
    confirmation_sent_at   DateTime.current
    unconfirmed_email      ''
    name                   'aaaa'
    nickname               ''
    image                  ''
    email                  'testemail2@mydomain.com'
    tokens                 {}
  end
end