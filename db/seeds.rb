# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# =============================
# 実験
# =============================

# == Checkinテーブル
collin = Checkin.create(
    user_id: "A",
    cafename: "collection",
    action: "IN"
    )
sleep(1)
collout = Checkin.create(
    user_id: "A",
    cafename: "collection",
    action: "OUT"
    )
sleep(1)
starin = Checkin.create(
    user_id: "A",
    cafename: "京 倶楽部 Cafe",
    action: "IN"
    )

# == Tmpplaceテーブル
tmpA = Tmpplace.create(
    user_id: "A",
    cafename: "NULL"
    )