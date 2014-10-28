# == ssersテーブル
User.create(
    id: "user01",
    username: "庄田１郎",
    sex: "Male"
    )
User.create(
    id: "user02",
    username: "庄田２郎",
    sex: "Male"
    )
User.create(
    id: "user03",
    username: "庄田さとみ",
    sex: "Female"
    )
User.create(
    id: "user04",
    username: "庄田美玲",
    sex: "Female"
    )


# == Checkテーブル
Check.create(
    user_id: "user01",
    cafename: "collection",
    action: "IN"
    )
sleep(1)
Check.create(
    user_id: "user02",
    cafename: "collection",
    action: "IN"
    )
sleep(1)
Check.create(
    user_id: "user03",
    cafename: "collection",
    action: "IN"
    )
sleep(1)
Check.create(
    user_id: "user04",
    cafename: "collection",
    action: "IN"
    )
# sleep(1)
# Check.create(
#     user_id: "user01",
#     cafename: "collection",
#     action: "OUT"
#     )
# sleep(1)
# Check.create(
#     user_id: "user02",
#     cafename: "collection",
#     action: "OUT"
#     )
# sleep(1)
# Check.create(
#     user_id: "user03",
#     cafename: "collection",
#     action: "OUT"
#     )
# sleep(1)
# Check.create(
#     user_id: "user04",
#     cafename: "collection",
#     action: "OUT"
#     )

# == Checkinテーブル
Checkin.create(
    user_id: "user01",
    cafename: "collection",
    status: "IN"
    )
Checkin.create(
    user_id: "user02",
    cafename: "collection",
    status: "IN"
    )
Checkin.create(
    user_id: "user03",
    cafename: "collection",
    status: "IN"
    )
Checkin.create(
    user_id: "user04",
    cafename: "collection",
    status: "IN"
    )