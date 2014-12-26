require 'rails_helper'

feature "Input a board game", %q(

As a dungeon master
I want to save the details of a board game that I won
So that I can have a digital record of it
Acceptance criteria

[ ] I must enter a name, publisher, description and release_data
[ ] If all fields are complete, I am told that my board game has been saved
[ ] If a field is incomplete, I am given an error message and broguth back to the input form.
[ ] If a board game already exists in the database, I am given an error message.

) do

  scenario 'user inputs a board game' do
    visit new_board_game_path

    fill_in "Name", with: "Settlers of Catan"
    fill_in "Publisher", with: "Mayfair Games"
    fill_in "Description", with: "Best game evar"
    select "2014", from: "board_game_release_date_1i"
    select "December", from: "board_game_release_date_2i"
    select "30", from: "board_game_release_date_3i"
    click_on "Create Board game"
    expect(page).to have_content("Board Game Created!")
  end
end
