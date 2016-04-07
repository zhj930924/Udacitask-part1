class TodoList
  attr_reader :title, :items
  # Initialize todo list with a title and no items
  def initialize(list_title)
    @title = list_title
    @items = Array.new # Starts empty! No Items yet!
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
            " " * (max_item_desc_len * 1.618 - item.description.length) +
            "Completed: #{item.completed_status}"
    end
  end

  # Print the formatted todo-list
  def print
    print_title
    print_items
    puts
  end

  # Save the list to a file
  def save
    @todolist_file = File.new('TodoList.txt', 'w+')
    save_title
    save_items
    @todolist_file.close
    puts 'File saved.'
  end

  # Load the list file if one already exists.
  def load
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
  def print_bar(symbol = '*', length = 20)
    puts symbol * length
  end

  def save_bar(symbol = '*', length = 20)
    @todolist_file.puts symbol * length
  end

  def save_items
    @items.each do |item|
      # Print index + descrition + golden ratio white space + completed
      @todolist_file.puts "#{items.index(item) + 1} - #{item.description}" +
            " " * (max_item_desc_len * 1.618 - item.description.length) +
            "Completed: #{item.completed_status}"
    end
  end

  def save_title
    @todolist_file.puts
    save_bar('*', @title.length)
    @todolist_file.puts @title
    save_bar('*', @title.length)
    @todolist_file.puts
  end
end

class Item
  attr_reader :description
  attr_accessor :completed_status

  # Initialize item with a description and marked as not complete
  def initialize(item_description) ## add optional deadline here
    @description = item_description
    @completed_status = false
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

  def deadline
  end

  def time_left
  end

  # Helper methods
  def make_bar(symbol = '*', length = 20)
    puts symbol * length
  end
end

# Allow multiple users to create their own to-do lists.
# Add due dates, optional due dates, times, etc.
