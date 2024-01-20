# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'
require 'open-uri'

url = 'http://tmdb.lewagon.com'
movie_serialized = URI.open(url).read
movie = JSON.parse(movie_serialized)

15.times do
  Movie.create(title: title.movie, overview: overview.movie, poster_url: "https://tmdb.lewagon.com/#{poster_url.movie}", rating: movie.vote_average)
end
require 'json', 'open-uri'

url = 'https://tmdb.lewagon.com/movie/top_rated'
movie_list_serialized = URI.open(url).read
movie_list = JSON.parse(movie_list_serialized)

15.times do |i|
  Movie.create(title: movie_list['results'][i]['title'], overview: movie_list['results'][i]['overview'],
               poster_url: "#{url}#{movie_list['results'][i]['poster_path']}",
               rating: movie_list['results'][i]['vote_average'])
end
