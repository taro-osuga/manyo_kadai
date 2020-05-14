# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
array4 = ["true","false"]
5.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "test#{n + 1}@test.com",
    password: "test#{n + 1}@test.com",
    admin: array4[rand(0..1)]
  )
end

array = ["未着手","着手中","完了"]
array1 = ["高","中","下"]
array2 = ["1","2","3","4","5"]
array3 = ["2020-05-01","2020-05-02","2020-05-03","2020-05-04","2020-05-05"]

200.times do |n|
    Task.create!(
      title: "test#{n + 1}",
      content: "テストコメント#{n + 1}",
      end_date: array3[rand(0..4)],
      status: array[rand(0..2)],
      priority: array1[rand(0..2)],
      user_id: array2[rand(0..4)]
    )
  end

5.times do |i|
  Label.create!(title: "sample#{i + 1}")
end