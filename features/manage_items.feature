Feature: Manage Items
	In order to run a store
	As a store owner
	I want to create and manage items
	
	Scenario: Hidden create item link as non-admin
		Given I am on the list of items
		Then I should not see "New Item"
		
	Scenario: Hide edit items links on item page
		Given I have 1 item called "T-Shirt"
		When I am on the item page for "T-Shirt"
		Then I should not see "Add Option"
		And I should not see "Edit"
		And I should not see "Destroy"
	
	Scenario: Try to create item as non-admin
		Given I am on the list of items
		When I go to the new item page
		Then I should see "Sign In"
		
	Scenario: Follow create item as admin
		Given an admin exists
		And I am signed in as an admin
		When I go to the new item page
		Then I should see "Create New Item"
		
	Scenario: Create blank item
		Given an admin exists
		And I am signed in as an admin
		And I have 0 items
		When I go to the new item page
		And I press "Save"
		Then I should see "New item not successfully created"
		And I should see "Create New Item"
		And I should have 0 items
		
	Scenario: Create valid item
		Given an admin exists
		And I am signed in as an admin
		And I have 0 items
		When I go to the new item page
		And I fill in "Name" with "T-Shirt"
		And I fill in "Price" with "5"
		And I fill in "Stock" with "10"
		And I fill in "Description" with "Some text."
		And I press "Save"
		Then I should see "New item successfully created"
		And I should see "T-Shirt"
		And I should see "Some text."
		And I should have 1 item
		
	Scenario: Create item with category
		Given an admin exists
		And I am signed in as an admin
		And I have 0 items
		And I have 2 categories called "Clothes", "Posters"
		When I go to the new item page
		And I fill in "Name" with "T-Shirt"
		And I fill in "Price" with "5"
		And I fill in "Stock" with "10"
		And I fill in "Description" with "Some text."
		And I check "Clothes"
		And I press "Save"
		Then I should see "New item successfully created"
		And I should see "T-Shirt"
		And I should see "Some text."
		And I should see "Clothes"
		And I should have 1 item
		
	Scenario: Update Item
		Given an admin exists
		And I am signed in as an admin
		And I have 1 item called "T-Shirt"
		When I go to the item page for "T-Shirt"
		And I follow "Edit"
		And I fill in "Name" with "Awesome T-Shirt"
		And I press "Save"
		Then I should see "Item successfully updated"
		And I should see "Awesome T-Shirt"
		
	Scenario: Delete existing item
		Given an admin exists
		And I am signed in as an admin
		And I have 1 item called "T-Shirt"
		When I go to the item page for "T-Shirt"
		And I follow "Destroy"
		Then I should see "Item successfully destroyed"
		And I should have 0 items
		
	Scenario: Add option to existing item
		Given an admin exists
		And I am signed in as an admin
		And I have 1 item called "T-Shirt"
		And I am on the item page for "T-Shirt"
		When I follow "Add Option"
		And fill in "Name" with "Super Thing"
		And fill in "Description" with "Textual description of option."
		And I press "Save"
		Then I should see "New item successfully created"
		And I should see "T-Shirt"
		And "T-Shirt" should have 1 option