require "application_system_test_case"

class RelationsTest < ApplicationSystemTestCase
  setup do
    @relation = relations(:one)
  end

  test "visiting the index" do
    visit relations_url
    assert_selector "h1", text: "Relations"
  end

  test "should create relation" do
    visit relations_url
    click_on "New relation"

    fill_in "Project", with: @relation.project_id
    fill_in "User", with: @relation.user_id
    click_on "Create Relation"

    assert_text "Relation was successfully created"
    click_on "Back"
  end

  test "should update Relation" do
    visit relation_url(@relation)
    click_on "Edit this relation", match: :first

    fill_in "Project", with: @relation.project_id
    fill_in "User", with: @relation.user_id
    click_on "Update Relation"

    assert_text "Relation was successfully updated"
    click_on "Back"
  end

  test "should destroy Relation" do
    visit relation_url(@relation)
    click_on "Destroy this relation", match: :first

    assert_text "Relation was successfully destroyed"
  end
end
