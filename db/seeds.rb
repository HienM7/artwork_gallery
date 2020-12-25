require 'faker'


# DUMMY USERS
puts "Seeding USERS table..."
puts "======================"

users = [
  ['admin0', true],
  ['admin1', true],
  ['admin2', true],
  ['member', false],
  ['member1', false],
  ['member2', false]
]
# default users
users.each do |name, is_admin|
  user = User.new
  user.username = name
  user.password = name
  user.password_confirmation = name
  user.email = "#{name}@dummymail.com"
  user.point = Faker::Number.within(range: 100..1000)
  user.is_admin = is_admin
  user.is_banned = false
  user.credit_card = Faker::PhoneNumber.cell_phone_in_e164[1..]
  user.save!
end
# more users
40.times do
  name = Faker::Name.unique.name.gsub! /\s/, '_'
  user = User.new
  user.username = name
  user.password = name
  user.password_confirmation = name
  user.email = "#{name}@dummymail.com"
  user.point = Faker::Number.within(range: 100..1000)
  user.is_admin = false
  user.is_banned = Faker::Boolean.boolean(true_ratio: 0.1)
  user.credit_card = Faker::PhoneNumber.cell_phone_in_e164[1..]
  user.save!
end


# DUMMY ARTWORKS
# puts "Seeding ARTWORKS table..."
# puts "======================"

# test_dir = 'TEST_artworks'
# artw_files = Dir.glob("app/assets/images/#{test_dir}/*") * 10

# default_artworks = artw_files.shuffle.collect { |af|
#   [
#     Faker::Movie.title,
#     "#{test_dir}/#{File.basename(af)}",
#     Faker::Number.within(range: 10..1000),
#     Faker::Boolean.boolean(true_ratio: 0.8) ? 1 : 0
#   ]
# }

# default_artworks.each do |name, path, value, is_public|
#   Artwork.create(

#     name: name,
#     img_link: path,
#     value: value,
#     is_public: is_public
#   )
# end


# DUMMY CATEGORIES
puts "Seeding CATEGORIES table..."
puts "======================"

cat_list = [
  '3D',
  'Adoptables',
  'Animation',
  'Anime and Manga',
  'Anthro',
  'Artisan Crafts',
  'Comics',
  'Cosplay',
  'Customization',
  'Digital Art',
  'Drawings and Paintings',
  'Emoji and Emoticon',
  'Fan Art',
  'Fan Fiction',
  'Fantasy',
  'Fractal',
  'Game Art',
  'Horror',
  'Literature',
  'Photo Manipulation',
  'Photography',
  'Pixel Art',
  'Poetry',
  'Resources',
  'Science Fiction',
  'Sculpture',
  'Stock Images',
  'Street Art',
  'Street Photography',
  'Traditional Art',
  'Wallpaper'
]

cat_list.shuffle.each do |name|
  Category.create(name: name)
end
