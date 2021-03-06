# Udacitask, Part 1


## Feature #1: Priority Feature
### Item class:
* initialize: Set default priority value to 0 (meaning it's off)
* set_priority: New method that allows users to set priority from a 1 to 5 scale.

### TodoList class:
* print_items : Add print Priority to print_list functionality.
* save_items : Add print Priority to save_list functionality.

---
## Feature #2: Save and Load Feature
### TodoList class:
#### Save
save_list: # Save the to-do list to a text file
save_title: Similar to print_title, save_title writes the title to the file.
save_items: Similar to print_items, save_items writes the items to the file.

#### Load
* load_list: Load the list file, clean it, and extract title, items descriptions, completion status to update current settings.
* load_title: Load title from the result of the string processing
* clean_up: Process text file to get items and their completion status
* load_items_description: Load item descriptions from the result of string processing
* load_items_completion_status: Load item completion statuses from the result of string processing
* load_file: Check if file exist, if exist, prepare it for string processing

---
## Feature #3: Pet Feature
### TodoList class:
* check_pet: Check if you have more than one items related to your pet, if not, your pet will be really angry.
* pet_is_angry: Prioritize pet-related items and ignore others. (set their priority to 1)
* release_rage: Your pet is really angry now, and (s)he decides to remove all the items on your to-do list (and prioritize his/hers).
* pet_first: Set pet's priority to five and upcase pet related items.
