require 'net/http'

url = URI("https://api.themoviedb.org/3/movie/popular?api_key=3f9ca7c706d7f715c7e6d7920cf6d167")
movies_json = Net::HTTP.get(url)
movies = JSON.parse(movies_json)

# Create movies and bookmarks
movies["results"].each do |movie|
  created_movie = Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
  # Create a bookmark for each movie in each list
  List.all.each do |list|
    Bookmark.create!(
      comment: "This is a comment.",
      movie: created_movie,
      list: list
    )
  end
  puts "Created successfully!"
end
