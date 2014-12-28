require 'rails_helper'

feature "Input a board game", %q(

As a dungeon master
I want to save the details of a board game that I won
So that I can have a digital record of it
Acceptance criteria
[x] Description should be a minimum of 50 characters
[x] I must enter a name, publisher, description and release_data
[x] If all fields are complete, I am told that my board game has been saved
[x] If a field is incomplete, I am given an error message and brought back to the input form.
[x] If a board game already exists in the database, I am given an error message.

) do


  before(:each) do
    visit new_board_game_path
  end


  scenario 'user inputs a board game' do


    fill_in "Name", with: "Settlers of Catan"
    fill_in "Publisher", with: "Mayfair Games"
    fill_in "Description", with: "Citizenry overcome injustice, natural resources empower maximize fight against malnutrition maintain plumpy'nut recognition. Synthesize complexity storytelling global time of extraordinary change meaningful work tackle. Gender equality; liberal combat poverty political."
    select "2014", from: "board_game_release_date_1i"
    select "December", from: "board_game_release_date_2i"
    select "30", from: "board_game_release_date_3i"
    click_on "Create Board game"
    expect(page).to have_content("Board Game Created!")
  end

  scenario 'user is given error if they forget to enter a board game' do

    fill_in "Publisher", with: "Mayfair Games"
    fill_in "Description", with: "Citizenry overcome injustice, natural resources empower maximize fight against malnutrition maintain plumpy'nut recognition. Synthesize complexity storytelling global time of extraordinary change meaningful work tackle. Gender equality; liberal combat poverty political."
    select "2014", from: "board_game_release_date_1i"
    select "December", from: "board_game_release_date_2i"
    select "30", from: "board_game_release_date_3i"
    click_on "Create Board game"


    expect(page).to have_content("Name can't be blank")


  end

  scenario 'user can\'t fill out blank fields' do

    click_on "Create Board game"
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Publisher can't be blank")
    expect(page).to have_content("Description is too short (minimum is 50 characters)")
    expect(page).to have_content("New Board Game")
  end

  scenario 'user enters duplicate board game' do
    board_game = BoardGame.create(
    name: "Monopoly",
    publisher: "Milton Bradley",
    description: "Citizenry overcome injustice, natural resources empower maximize fight against malnutrition maintain plumpy'nut recognition. Synthesize complexity storytelling global time of extraordinary change meaningful work tackle. Gender equality; liberal combat poverty political.",
    release_date: Date.today
    )

    month = Date::MONTHNAMES[board_game.release_date.month]

    fill_in "Name", with: board_game.name
    fill_in "Publisher", with: board_game.publisher
    fill_in "Description", with: board_game.description
    select board_game.release_date.year, from: "board_game_release_date_1i"
    select month, from: "board_game_release_date_2i"
    select board_game.release_date.day, from: "board_game_release_date_3i"
    click_on "Create Board game"
    expect(page).to have_content("This board game already exists")
  end

end
