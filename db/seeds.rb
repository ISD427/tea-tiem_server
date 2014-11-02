# == ssersテーブル
User.create(
    id: "user01",
    username: "庄田１郎",
    sex: "Male",
    profile: "profileだよ"
    )
User.create(
    id: "user02",
    username: "庄田２郎",
    sex: "Male",
    profile: "profileだよ"
    )
User.create(
    id: "user03",
    username: "庄田３郎",
    sex: "Male",
    profile: "profileだよ"
    )
User.create(
    id: "user11",
    username: "庄田１子",
    sex: "Female",
    profile: "profileだよ"
    )
User.create(
    id: "user12",
    username: "庄田２子",
    sex: "Female",
    profile: "profileだよ"
    )
User.create(
    id: "user13",
    username: "庄田３子",
    sex: "Female",
    profile: "profileだよ"
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
Friendship.create(
    source_id: "user01",
    target_id: "user11",
    first_time: true,
    cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
    )
Friendship.create(
    source_id: "user01",
    target_id: "user12",
    first_time: true,
    cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
    )
Friendship.create(
    source_id: "user01",
    target_id: "user13",
    first_time: false,
    cafename: "ドトールコーヒーショップ 京都四条通り店"
    )

Friendship.create(
    source_id: "user02",
    target_id: "user11",
    first_time: false,
    cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
    )
Friendship.create(
    source_id: "user02",
    target_id: "user12",
    first_time: true,
    cafename: "スターバックスコーヒー京都四条通ヤサカビル店"
    )
Friendship.create(
    source_id: "user02",
    target_id: "user13",
    first_time: false,
    cafename: "ドトールコーヒーショップ 京都四条通り店"
    )

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