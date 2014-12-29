require 'rails_helper'

feature "User sign up", %q(
"As a Board Game Fanboy (or Fangirl)
I want to sign up for the Game Collector application
So that I can use all of its awesome features.

Acceptance Criteria

[x] There is a link to 'Sign Up' on the homepage.
[x] If I fill in my first name, last name, email, password, and password confirmation correctly, I am greeted with a confirmation message that my account has been created.
[x] If the password and password confirmation fields do not match, I am given an error message.
  [x] If my email already exists in the database, I am given a message that tells me I have already registered.
  [x] If my email is not formatted correctly, I am given an error message."

) do
    scenario "user provides valid information" do
      visit root_path
      click_on "Sign Up"

      fill_in "First Name", with: "Gene"
      fill_in "Last Name", with: "Parmesean"
      fill_in "Email", with: "gparmesean@privatateeyes.com"
      fill_in "Password", with: "supersecret"
      fill_in "Password confirmation", with: "supersecret"
      click_on "Sign up"
      expect(page).to have_content "Welcome! Your account has been created."
      expect(page).to_not have_link "Sign Up"
      expect(page).to have_link "Sign Out"

    end


    scenario "password fields do not match" do
      visit root_path
      click_on "Sign Up"

      fill_in "First Name", with: "Gene"
      fill_in "Last Name", with: "Parmesean"
      fill_in "Email", with: "gparmesean@privatateeyes.com"
      fill_in "Password", with: "supersecret"
      fill_in "Password confirmation", with: "notmypassword"
      click_on "Sign up"
      expect(page).to have_content "Password confirmation doesn't match"

    end

    scenario "email is already registered" do
      existing_user = User.create(
        first_name: "Gene",
        last_name: "Parmesean",
        email: "gparmesean@privatateeyes.com",
        password: "supersecret",
      )


      visit root_path
      click_on "Sign Up"

      fill_in "First Name", with: existing_user.first_name
      fill_in "Last Name", with: existing_user.last_name
      fill_in "Email", with: existing_user.email
      fill_in "Password", with: existing_user.password
      fill_in "Password confirmation", with: existing_user.password
      click_on "Sign up"

      expect(page).to have_content "Email has already been taken"

    end

    scenario "improperly formatted email" do
      visit root_path
      click_on "Sign Up"

      fill_in "First Name", with: "Gene"
      fill_in "Last Name", with: "Parmesean"
      fill_in "Email", with: "gparm"
      fill_in "Password", with: "supersecret"
      fill_in "Password confirmation", with: "supersecret"
      click_on "Sign up"
      expect(page).to have_content "Email is invalid"

    end









end
