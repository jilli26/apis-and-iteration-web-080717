require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  array_of_film_urls = nil
  character_hash["results"].each do |element|
    if element["name"] == character
      array_of_film_urls = element["films"]
    end
  end
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  array_of_film_hashes = array_of_film_urls.collect do |film_url|
    film_info = RestClient.get(film_url)
    films_hash = JSON.parse(film_info)
  end
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
array_of_film_hashes
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.collect do |hash|
    puts hash["title"]
  end
end

binding.pry

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

get_character_movies_from_api("Luke Skywalker")
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
