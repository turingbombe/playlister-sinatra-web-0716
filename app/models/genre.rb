class Genre < ActiveRecord::Base
  belongs_to :song
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

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