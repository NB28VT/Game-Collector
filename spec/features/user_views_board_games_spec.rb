require 'rails_helper'

feature "View list of board games", %q(

As a visitor of the game game collector website
I want to see a list of board games
So that I can learn about awesome games
Acceptance criteria
[ ] If I navigate to the /board_games path, I should see a list of games

) do

  scenario "views list of board games" do

    games = []
    3.times do |x|
      attrs = {
        name: "Jenga#{x}",
        publisher: "Hasbro",
        description: "Citizenry overcome injustice, natural resources empower maximize fight against malnutrition maintain plumpy'nut recognition. Synthesize complexity storytelling global time of extraordinary change meaningful work tackle. Gender equality; liberal combat poverty political.",
        release_date: 2.weeks.ago
      }
      games << BoardGame.create(attrs)
    end

    visit board_games_path
    games.each do |game|
      expect(page).to have_content game.name
    end

  end


end
