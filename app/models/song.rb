class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres  
  has_many :genres, through: :song_genres

  def slug
    slug = self.name.downcase
    if slug.include?(" ")
      slug = slug.split(" ").join("-")
    end
    slug
  end

  def self.find_by_slug(slug)
    # binding.pry
    slug = slug.split("-").join(" ").titlecase
    self.find_by(name: slug)
  end
end