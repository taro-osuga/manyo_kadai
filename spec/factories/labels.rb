FactoryBot.define do
  factory :label do
    title { "sample1" }
  end
  factory :label2 , class: Label do
    title { "sample2" }
  end
  factory :label3 , class: Label do
    title { "sample3" }
  end
  factory :label4 , class: Label do
    title { "sample4" }
  end
  factory :label5 , class: Label do
    title { "sample5" }
  end
end
