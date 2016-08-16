class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    slug = self.name.downcase
    if slug.include?(" ")
      slug = slug.split(" ").join("-")
    end
    slug
  end

  def self.find_by_slug(slug)
    slug = slug.split("-").join(" ").titlecase
    self.find_by(name: slug)
  end
end