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
check_pet("Roxy")

# Print the list
todo.print_list
