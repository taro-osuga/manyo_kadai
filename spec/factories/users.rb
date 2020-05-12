FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'sample' }
    email { 'sample@example.com' }
    password { '00000000' }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 2 }
    name { 'admin' }
    email { 'admin@example.com' }
    password { '22222222' }
    admin { true }
  end
  factory :user2, class: User do
    id { 3 }
    name { 'sample3' }
    email { 'sample3@example.com' }
    password { '11111111' }
    admin { false }
  end
end