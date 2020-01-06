# 5.times do |index|
#   i = index + 1
#   user = User.create(
#     nickname:           "user_#{i}",
#     email:  "email_#{i}@example.com",
#     password:               "#{i}password#{i}",
#     password_confirmation:  "#{i}password#{i}",
#     l_name:           "苗字(user#{i})",
#     f_name:           "名前(user#{i})",
#     l_name_kana:           "ミョウジ(user#{i})",
#     f_name_kana:           "ナマエ(user#{i})",
#     phone_num:           "0900000000#{i}",
#     authentication_num:           "123#{i}"
#   )
#   user.save!
# end