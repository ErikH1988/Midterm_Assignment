require 'json'
require 'rest-client'

def search_input(stars)
    if stars == 1 || stars == 0
        json_metascore_upper = 20
        json_metascore_lower = 0
    elsif stars == 2
        json_metascore_upper = 40
        json_metascore_lower = 21
    elsif stars == 3
        json_metascore_upper = 60
        json_metascore_lower = 41
    elsif stars == 4
        json_metascore_upper = 80
        json_metascore_lower = 61
    elsif stars == 5
        json_metascore_upper = 100
        json_metascore_lower = 81
    else puts 'Sorry you need to choose a number between 0 and 5'
    end

    search_results(json_metascore_lower, json_metascore_upper)
end




def search_results(json_metascore_lower, json_metascore_upper)

  search_results_array = []

    rest_data = RestClient.get('http://www.myapifilms.com/imdb/top')
    json_data = JSON.parse(rest_data)

    json_data.each do |movie|
    movie_rating = movie["rating"].to_f*10
        if movie_rating > json_metascore_lower && movie_rating < json_metascore_upper
            search_results_array << movie
        end
    end
  if search_results_array.length > 0
    puts 'We found the following results:'
    search_results_array.each do |movie|
      movie_title = movie["title"]
      movie_rating = movie["rating"]
      movie_year = movie["year"]

      puts "Title: #{movie_title} | Rating: #{movie_rating} | Year: #{movie_year}"
    end
  else
    puts "Sorry we didnt get any search results for you."
  end
end

puts 'Find movies based on the number of stars out of five'
puts 'How many stars do you want?'

stars = gets.chomp.to_i

search_input(stars)