require "rails_helper"

feature "users sees all challenges", %{
  As a user
  I can see an index of challenges
  So that I can select a challenge to join.

  Acceptance Criteria:
  - [X] I can see title of the challenge
  - [X] I can see a brief tagline of the challenge
} do
  let!(:challenge) { FactoryGirl.create(:challenge) }

  scenario "unauthenticated user sees list of challenges" do
    visit root_path
    expect(page).to_not have_content(challenge.title)
    click_on "Challenges"
    expect(page).to have_content(challenge.title)
    expect(page).to have_content(challenge.tagline)
  end

  scenario "authenticated user sees list of challenges" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Login", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_on "Challenges"
    expect(page).to have_content(challenge.title)
  end
end
