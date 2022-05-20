FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'abcd1234' }
    first_name { 'example' }
    last_name { 'try-out' }

    factory :admin do
      admin { true }
    end
  end

  factory :comment do
    text { "MyString" }
    user
    post
  end

  factory :post do
    title { 'Some title' }
    category { 'review' }
  end
  
  factory :saved_post do
    user
    post
  end
  
  factory :tagging do
    post
    tag
  end
  
  factory :tag do
    
  end
end