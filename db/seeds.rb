# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
u = User.find(1)
u.name = "Jun IIO"
u.role = "teacher,admin"
u.save
p = Project.create(
    name: "Tokyo University (JP) and Taiwan National University (TW)",
    year: 2025, memo: "This is a test project.")
s = School.create(
    name: "Tokyo University", address: "3-8-1 Hongo, Bunkyo-ku, Tokyo")
p.schools << s
u.schools << s
us = UserSchool.find_by(user: u, school: s); us.registered = true; us.save
s = School.create(
    name: "National Taiwan University", address: "Taipei, Taiwan")
p.schools << s
u.schools << s
us = UserSchool.find_by(user: u, school: s); us.registered = true; us.save
p = Project.create(
    name: "Chuo University (JP) and King Mongkut's Institute of Technology Ladkrabang (TH)",
    year: 2024, memo: "This is a test project (2).")
s = School.create(
    name: "Chuo University", address: "1-18 Ichigaya-tamachi, Shinjuku, Tokyo, JAPAN")
p.schools << s
u.schools << s
us = UserSchool.find_by(user: u, school: s); us.registered = true; us.save
s = School.create(
    name: "King Mongkut's Institute of Technology Ladkrabang", address: "Ladkrabang, Bangkok, Thailand")
p.schools << s
u.schools << s
us = UserSchool.find_by(user: u, school: s); us.registered = true; us.save
p = Project.create(
    name: "Chuo University (JP), UTM (MY) and Thammasat University (TH)",
    year: 2023, memo: "This is a test project (3).")
s = School.create(
    name: "Chuo University (Hachioji)", address: "742-1 Higashinakano, Hachioji-shi, Tokyo, JAPAN")
p.schools << s
u.schools << s
us = UserSchool.find_by(user: u, school: s); us.registered = true; us.save
s = School.create(
    name: "University of Technology Malaysia (UTM)", address: "JB, MY")
p.schools << s
u.schools << s
us = UserSchool.find_by(user: u, school: s); us.registered = true; us.save
s = School.create(
    name: "Thammasat University", address: "Bangkok, Thailand")
p.schools << s
u.schools << s
us = UserSchool.find_by(user: u, school: s); us.registered = true; us.save
