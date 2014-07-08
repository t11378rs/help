require "open-uri"

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do #User.create!を実行する前に、RakeタスクがUserモデルなどのローカルのRails環境にアクセスできるようにします
    User.create!(name: "Ryosuke Sakai",
                 email: "ryo0717@gmail.com",
                 password: "19920717",
                 password_confirmation: "19920717",
                 admin: true)
    User.create!(name: "Example User",
                 email: "example@railstutorial.jp",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    98.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.jp"
      password  = "password"
      User.create!(name: name, #create!は基本的にcreateメソッドと同じものですが、ユーザーが無効な場合にfalseを返すのではなく例外を発生させる
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.find([1, 2])
    50.times do
      title = "ヘルプだよ！助けてくれ！"
      #image_url = ImageUploader.new
      #image_url = open("http://web.sfc.keio.ac.jp/~t11378rs/example2.jpg").string
      #image_url 
      #image_url = "http://www.workabroad.jp/assets/logo_header_mark-12a043dc84a0e99b3540565dd6ec0d57.png"
      desired_time = "月曜2限、5限 水曜3限"#Faker::Lorem.sentence(1)
      desired_place = "メディアセンター、食堂、特教" #Faker::Lorem.sentence(1)
      reward = "1000円" #Faker::Lorem.sentence(1)
      detail = Faker::Lorem.sentence(100)
      users.each { |user| user.helpposts.create!(title: title, 
                                                image_url: open("#{Rails.root}/public/uploads/20140704031017.jpg"), #open("http://web.sfc.keio.ac.jp/~t11378rs/example2.jpg").string,
                                                desired_time: desired_time,
                                                desired_place: desired_place,
                                                reward: reward,
                                                detail: detail) }
    end
    helpposts = Helppost.find([1,2,3,4,5,6])
    5.times do
      text = "大丈夫？手伝おうか？てかLineやってる？"
      user_id = 1
      helpposts.each { |helppost| helppost.comments.create!(text: text,
                                                            user_id: user_id)}
    end
  end
end

=begin
belong_to ユーザー
ユーザー     user_id:integer
タイトル     title:string
画像     image_url:string
いつ助けて欲しいか     desired_time:string
どこで助けて欲しいか     desired_place:string
報酬     reward:string
詳細     detail:text
has_many コメント
=end