require 'faker'

test_dir = 'TEST_artworks'
artw_files = Dir.glob("app/assets/images/#{test_dir}/*") * 10

default_artworks = artw_files.shuffle.collect { |af|
  [
    Faker::Movie.title,
    "#{test_dir}/#{File.basename(af)}",
    Faker::Number.within(range: 10..1000),
    Faker::Boolean.boolean(true_ratio: 0.8) ? 1 : 0
  ]
}

default_artworks.each do |name, path, value, is_public|
  Artwork.create(
    name: name,
    img_link: path,
    value: value,
    is_public: is_public
  )
end


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
