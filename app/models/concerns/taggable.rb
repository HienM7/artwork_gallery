module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    after_save :save_tags
  end

  def tag_names
    # `tagnames`: permitted param access via `attr_accessor` in Artwork model
    tagnames.blank? ? tags.map(&:name).join(',') : tagnames
  end

  def tag_names=(names)
    tagnames = names
  end

  private
    # def create_tags
    #   # supposed to be the same as `save_tags`
    #   tag_names = tag_names.split(',')

    #   tag_ids = Tag.upsert_all(
    #     tag_names.map { |tname| { name: tname } },
    #     unique_by: [:name]
    #   )

    #   taggings = tag_ids.map { |tid| { tag_id: tid, artwork_id: self.id } }

    #   Tagging.upsert_all(taggings)
    # end

    def save_tags
      # split the tag names and save them into our database if they don't exist
      tag_names.split(',').each do |name|
        tag = Tag.find_or_create_by(
          name: name.strip.parameterize(separator: '-')
        )
        tags << tag unless tags.exists?(tag.id)
      end
      clean_tags
    end

    def clean_tags
      # remove tags no longer in the list provided when editing artwork's tags
      names = tag_names
        .split(',')
        .map { |n| n.strip.parameterize(separator: '-') }

      tags.each do |tag|
        tags.destroy(tag) unless names.include?(tag.name)
      end
    end
end
