# == usersテーブル
User.create(
    id: "user01",
    username: "1郎",
    sex: "Male",
    profile: "profileだよ",
    age: 24,
    image: URI.parse("http://www8391uo.sakura.ne.jp/images/male1.jpg")
    )
User.create(
    id: "user02",
    username: "2郎",
    sex: "Male",
    profile: "profileだよ",
    age: 24,
    image: URI.parse("http://www8391uo.sakura.ne.jp/images/male2.jpg")
    )
User.create(
    id: "user03",
    username: "3郎",
    sex: "Male",
    profile: "profileだよ",
    age: 24,
    image: URI.parse("http://www8391uo.sakura.ne.jp/images/male3.jpg")
    )
User.create(
    id: "user11",
    username: "1子",
    sex: "Female",
    profile: "profileだよ",
    age: 24,
    image: URI.parse("http://www8391uo.sakura.ne.jp/images/female1.png")
    )
User.create(
    id: "user12",
    username: "2子",
    sex: "Female",
    profile: "profileだよ",
    age: 24,
    image: URI.parse("http://www8391uo.sakura.ne.jp/images/female2.jpg")
    )
User.create(
    id: "user13",
    username: "3子",
    sex: "Female",
    profile: "profileだよ",
    age: 24,
    image: URI.parse("http://www8391uo.sakura.ne.jp/images/female3.jpg")
    )
User.create(
    id: "user14",
    username: "4子",
    sex: "Female",
    profile: "profileだよ",
    age: 24,
    image: URI.parse("http://www8391uo.sakura.ne.jp/images/female4.jpg")
    )
User.create(
    id: "user15",
    username: "5子",
    sex: "Female",
    profile: "profileだよ",
    age: 24,
    image: URI.parse("http://www8391uo.sakura.ne.jp/images/female5.jpg")
    )
# == Statusテーブル
Status.create(
    user_id: "user01",
    status: "OUT"
    )
Status.create(
    user_id: "user02",
    status: "OUT"
    )
Status.create(
    user_id: "user03",
    status: "OUT"
    )
Status.create(
    user_id: "user11",
    status: "OUT"
    )
Status.create(
    user_id: "user12",
    status: "OUT"
    )
Status.create(
    user_id: "user13",
    status: "OUT"
    )
Status.create(
    user_id: "user14",
    status: "OUT"
    )
Status.create(
    user_id: "user15",
    status: "OUT"
    )
# == Friendshipsテーブル
# Friendship.create(
#     source_id: "user01",
#     target_id: "user11",
#     count:1,
#     cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
#     )
# Friendship.create(
#     source_id: "user01",
#     target_id: "user12",
#     count:1,
#     cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
#     )
# Friendship.create(
#     source_id: "user01",
#     target_id: "user13",
#     count:1,
#     cafename: "ドトールコーヒーショップ 京都四条通り店"
#     )

# Friendship.create(
#     source_id: "user01",
#     target_id: "user14",
#     count:1,
#     cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
#     )
# Friendship.create(
#     source_id: "user02",
#     target_id: "user15",
#     count:1,
#     cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
#     )

# == messagesテーブル
Message.create(
    source_id: "user01",
    target_id: "user11",
    message: "こんにちは！１郎です",
    deleted: false
    )
sleep(1)
Message.create(
    source_id: "user11",
    target_id: "user01",
    message: "はじめまして！１子ですわ",
    deleted: false
    )
sleep(1)
Message.create(
    source_id: "user01",
    target_id: "user11",
    message: "１子って素敵な名前ですね",
    deleted: false
    )
sleep(1)
Message.create(
    source_id: "user11",
    target_id: "user01",
    message: "ありがとうございます！",
    deleted: false
    )