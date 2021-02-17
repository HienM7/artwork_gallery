module ArtworksHelper
  def show_categories
    @categories = Category.all.map {|ca| [ca.name, ca.id]}
  end

  def similar_artworks(artw, num: 6)
    @similar = artw
      .category.artworks
      .left_joins(:favorites)
      .group(:id)
      .select('artworks.*, COUNT(artworks.id)*random() AS likelihood')
      .where('artworks.id <> ?', artw.id)
      .order('likelihood DESC').limit(num)
  end

  def same_authors_artworks(artw, num: 6)
    @same_author = artw
      .user.artworks
      .left_joins(:favorites)
      .group(:id)
      .select('artworks.*, COUNT(artworks.id)*random() AS likelihood')
      .where('artworks.id <> ?', artw.id)
      .order('likelihood DESC').limit(num)
  end
end
