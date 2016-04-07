require_relative 'todolist.rb'

# Creates a new todo list
todo = TodoList.new("My first Udacitask list")

# Add four new items
todo.add_item("Hiking in Yosemite National Park")
todo.add_item("Shop groceries at Costco")
todo.add_item("Buy pet food for Roxy")
todo.add_item("Finish Udacity project")

# Print the list
todo.print_list

# Delete the first item
todo.delete_item(1)

# Print the list
todo.print_list

# Delete the second item
todo.delete_item(2)

# Print the list
todo.print_list

# Update the completion status of the first item to complete
todo.items[0].update

# Print the list
todo.print_list

# Update the title of the list
todo.rename("Updated title")

# Print the list
todo.print_list

# Check if I care about my pet
todo.check_pet("Roxy")

# Print the list
todo.print_list

# Save the list
todo.save_list

# What will happen if I have one pet related item?

# Create a new list
newlist = TodoList.new("Not so important to-do list")

# Add one pet related item and some other to the list
newlist.add_item("Hiking in Yosemite National Park")
newlist.add_item("Shop groceries at Costco")
newlist.add_item("Finish Udacity project")
newlist.add_item("Bring Roxy to Death Valley National Park")

# Print the list
newlist.print_list

# Check pet again
newlist.check_pet("Roxy")

# See what happened
newlist.print_list
