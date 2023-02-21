class GamesController < ApplicationController

  def new
    # TODO: generate random grid of letters
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @letters.join(" ")
    puts @letters
  end

  def score
    raise
    # The word can’t be built out of the original grid

    # The word is valid according to the grid, but is not a valid English word
    word = params[:word]

    # The word is valid according to the grid and is an English word
    if included?(params[:word].upcase, grid)
      if english_word?(params[:word])
        score = compute_score(attempt, time)
        [score, "well done"]
      else
        [0, "not an english word"]
      end
      else
        [0, "not in the grid"]
      end
  end
end

private

def english_word?(word)
  response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
