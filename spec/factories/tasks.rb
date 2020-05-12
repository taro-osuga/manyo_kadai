FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    end_date {'2020-05-05'}
    status {'未着手'}
    priority {:高}
    user 
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル2' }
    content { 'Factoryで作ったデフォルトのコンテント2' }
    end_date {'2020-05-06'}
    status {'完了'}
    priority {:中}
    user
  end
  factory :third_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル3' }
    content { 'Factoryで作ったデフォルトのコンテント3' }
    end_date {'2020-05-07'}
    status {'着手中'}
    priority {:下}
    user
  end
end
