class TodoList
  attr_reader :title, :items
  # Initialize todo list with a title and no items
  def initialize(list_title)
    @title = list_title
    @items = Array.new # Starts empty! No Items yet!
  end

  # Check if you have more than one items related to your pet, if not, your pet will be angry
  def check_pet(pet_name)
    @pet_name = pet_name
    count = 0
    @items.each { |item| count += 1 if item.upcase.include?(@pet_name.upcase) }
    if count > 1
      puts "You have #{count} item(s) related to your pet."
    elsif count == 1
      pet_is_angry
    else
      release_rage
    end
  end

  # Your pet is really angry now, and (s)he decides to remove all the items on your to-do list.
  def release_rage
    clear_items
    add_item('Love your pet!')
    @items[0].set_priority(5)
    puts 'Your pet''s rage has been released, please print your Udacitask.'
  end

  # Prioritize pet-related items and ignore others. (set their priority to 1)
  def pet_is_angry
    @items.each do |item|
      if item.description.upcase.include?(@pet_name.upcase)
        pet_first(item)
      else
        item.set_priority(1)
      end
    end
  end

  # Set pet's priority to five and upcase pet related items.
  def pet_first(item)
    item.description.upcase!
    item.set_priority(5)
    @items.insert(0, @items.delete(item))
  end

  # Creates a new Item by its description and adds it to the array of Items
  def add_item(new_item_desc)
    item = Item.new(new_item_desc)
    @items.push(item)
  end

  # Delete an item from the array of Items
  def delete_item(item_index)
    if item_index <= @items.length
      deleted = @items.delete_at(item_index - 1)
      puts "#{deleted.description} is deleted from the TodoList"
    else
      puts 'Please enter a valid index!'
    end
  end

  # Rename the title of the array
  def rename(list_title)
    @title = list_title
    puts 'Title of your Udacitask has been successfully changed!'
  end

  # Sub-method for print
  def print_title
    puts
    print_bar('*', @title.length)
    puts @title
    print_bar('*', @title.length)
    puts
  end

  # Sub-method for print
  def max_item_desc_len
    max = 0
    @items.each do |item|
      max = item.description.length if item.description.length > max
    end
    max
  end

  # Sub-method for print
  def print_items
    @items.each do |item|
      # Print index + descrition + golden ratio white space + completed
      puts "#{items.index(item) + 1} - #{item.description}" +
            " " * (max_item_desc_len * 1.618 - item.description.length) + "Priority: #{item.priority}" + " " * 5 +
            "Completed: #{item.completed_status}"
    end
  end

  # Print the formatted todo-list
  def print_list
    print_title
    print_items
    puts
  end

  # Save the to-do list to a text file
  def save_list
    @todolist_file = File.new('TodoList.txt', 'w+')
    save_title
    save_items
    @todolist_file.close
    puts 'File saved.'
  end

  # Load the list file, clean it, and extract title, items descriptions, completion status to update current settings.
  def load_list
    load_file
    load_title
    clean_up
    clear_items
    load_items_description
    load_items_completion_status
    puts 'Udacitask successfully loaded'
  end

  # Check if file exist, if exist, prepare it for string processing
  def load_file
    @text = File.open('TodoList.txt', 'r') if File.exist?('TodoList.txt')
    @temp = []
    @text.each_line { |line| @temp.push(line) }
  end

  # Load title from the result of the string processing
  def load_title
    @title = @temp[2]
  end

  # Clear items in the todo-list, this one is dangerous
  def clear_items
    @items.clear
  end

  # Process text to get items and their completion status
  def clean_up
    @load_items = []
    @load_completion_status = []
    @temp2 = @temp[5, @temp.size].to_s.split('\n')
    @temp2.each { |s| s.delete! '\\' }
    @temp2.each { |s| s.delete! '[",]' }
    @temp2 = @temp2.reject { |s| s.empty? }
    @temp2.each { |s| @load_items.push(s[/(\d -(( \w+)?)+)/].split(' - ')) }
    @temp2.each { |s| @load_completion_status.push(s[/Completed: \w+/].split('Completed: ')) }
    @load_completion_status = @load_completion_status.flatten.reject { |s| s.empty? }
  end

  # Load item descriptions from the result of string processing
  def load_items_description
    @load_description = []
    @load_items.each do |item|
      @load_description.push(item[1])
    end
    @load_description.each do |item|
      add_item(item)
    end
  end

  # Load item completion statuses from the result of string processing
  def load_items_completion_status
    @load_completion_status.each do |status|
      @items.each do |item|
        item.completed_status = status
      end
    end
  end

  # Helper methods

  # Puts a customizable bar
  def print_bar(symbol = '*', length = 20)
    puts symbol * length
  end

  # Write a customizable bar to the file.
  def save_bar(symbol = '*', length = 20)
    @todolist_file.puts symbol * length
  end

  # Similar to print_items, save_items writes the items to the file.
  def save_items
    @items.each do |item|
      # Print index + descrition + golden ratio white space + completed
      @todolist_file.puts "#{items.index(item) + 1} - #{item.description}" +
            " " * (max_item_desc_len * 1.618 - item.description.length) +
            "Priority: #{item.priority}" + " " * 5 +
            "Completed: #{item.completed_status}"
    end
  end

  # Similar to print_title, save_title writes the title to the file.
  def save_title
    @todolist_file.puts
    save_bar('*', @title.length)
    @todolist_file.puts @title
    save_bar('*', @title.length)
    @todolist_file.puts
  end
end

class Item
  attr_reader :description, :priority
  attr_accessor :completed_status

  # Initialize item with a description and marked as not complete
  def initialize(item_description) ## add optional deadline here
    @description = item_description
    @completed_status = false
    @priority = 0
  end

  # Add priority from 1 to 5 scale
  def set_priority(priority)
    if priority == 1
      @priority = 1
      puts "Priority set to #{priority} - No big deal"
    elsif priority == 2
      @priority = 2
      puts "Priority set to #{priority} - Low"
    elsif priority == 3
      @priority = 3
      puts "Priority set to #{priority} - Moderate"
    elsif priority == 4
      @priority = 4
      puts "Priority set to #{priority} - Serious"
    elsif priority == 5
      @priority = 5
      puts "Priority set to #{priority} - Critical"
    else
      puts 'Please enter a valid priority'
    end
  end

  # Update the completion status of an item
  def update
    # If it's not done, mark it as done, and vice versa
    @completed_status = !@completed_status
    puts "The completion status of #{@description} is now #{completed_status}."
  end

   # Check if an item is completed; return boolean.
  def completed?
    @completed_status == true
  end

  # print
  def show
    puts
    make_bar('*', @description.length + 13)
    puts "Description: #{@description}"
    puts "Completion Status: #{@completed_status}"
    make_bar('*', @description.length + 13)
    puts
  end

  # Helper methods
  def make_bar(symbol = '*', length = 20)
    puts symbol * length
  end
end

# Allow multiple users to create their own to-do lists.
# Add due dates, optional due dates, times, etc.
