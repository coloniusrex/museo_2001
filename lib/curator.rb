class Curator

attr_reader :photographs, :artists
  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find { |artist| artist.id == id}
  end

  def photographs_by_artist
    @artists.reduce({}) do |artist_photos, artist|
      find = @photographs.find_all { |photo| photo.artist_id == artist.id}
      artist_photos[artist] = find
      artist_photos
    end
  end

  def artists_with_multiple_photographs
    photographs_by_artist.select do |artist, photos|
       photos.length > 1
    end.keys
  end

  def photographs_taken_by_artist_from(country)
    a = photographs_by_artist.select do |artist, photos|
      artist.country == country
    end.values.flatten
  end
end
