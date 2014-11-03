# == usersテーブル
User.create(
    id: "user01",
    username: "1郎",
    sex: "Male",
    profile: "profileだよ",
    age: 24,
    image: File.open("/Users/admin/Pictures/male1.jpg")
    )
User.create(
    id: "user02",
    username: "2郎",
    sex: "Male",
    profile: "profileだよ",
    age: 24,
    image: File.open("/Users/admin/Pictures/male2.jpg")
    )
User.create(
    id: "user03",
    username: "3郎",
    sex: "Male",
    profile: "profileだよ",
    age: 24,
    image: File.open("/Users/admin/Pictures/male3.jpg")
    )
User.create(
    id: "user11",
    username: "1子",
    sex: "Female",
    profile: "profileだよ",
    age: 24,
    image: File.open("/Users/admin/Pictures/female1.png")
    )
User.create(
    id: "user12",
    username: "2子",
    sex: "Female",
    profile: "profileだよ",
    age: 24,
    image: File.open("/Users/admin/Pictures/female2.jpg")
    )
User.create(
    id: "user13",
    username: "3子",
    sex: "Female",
    profile: "profileだよ",
    age: 24,
    image: File.open("/Users/admin/Pictures/female3.jpg")
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

# == Friendshipsテーブル
# Friendship.create(
#     source_id: "user01",
#     target_id: "user11",
#     first_time: true,
#     cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
#     )
# Friendship.create(
#     source_id: "user01",
#     target_id: "user12",
#     first_time: true,
#     cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
#     )
# Friendship.create(
#     source_id: "user01",
#     target_id: "user13",
#     first_time: false,
#     cafename: "ドトールコーヒーショップ 京都四条通り店"
#     )

# Friendship.create(
#     source_id: "user02",
#     target_id: "user11",
#     first_time: false,
#     cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
#     )
# Friendship.create(
#     source_id: "user02",
#     target_id: "user12",
#     first_time: true,
#     cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
#     )
# Friendship.create(
#     source_id: "user02",
#     target_id: "user13",
#     first_time: false,
#     cafename: "ドトールコーヒーショップ 京都四条通り店"
#     )

# == messagesテーブル
Message.create(
    source_id: "user01",
    target_id: "user11",
    message: "こんにちは！庄田１郎です",
    deleted: false
    )
sleep(1)
Message.create(
    source_id: "user11",
    target_id: "user01",
    message: "はじめまして！庄田１子ですわ",
    deleted: false
    )
sleep(1)
Message.create(
    source_id: "user01",
    target_id: "user11",
    message: "あなたも庄田ですか．奇遇ですね",
    deleted: false
    )
sleep(1)
Message.create(
    source_id: "user11",
    target_id: "user01",
    message: "ほんとですね＾＾",
    deleted: false
    )