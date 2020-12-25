module ArtworksHelper
  def show_categories
    @categories = Category.all.map {|ca| [ca.name, ca.id]}
  end
end
