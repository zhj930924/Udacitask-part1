class TodoList
  attr_reader :title, :items
  # Initialize todo list with a title and no items
  def initialize(list_title)
    @title = list_title
    @items = Array.new # Starts empty! No Items yet!
  end

  # Creates a new Item and adds it to the array of Items
  def add_item(new_item)
    item = Item.new(new_item)
    @items.push(item)
  end

  # Delete an item from the array of Items
  def delete_item(item)
    if @items.include?(item)
      @items.delete(item)
      puts '#{item} is deleted from the TodoList'
    else
      puts 'The item you want to delete doesn''t exist'
    end
  end

  # Renaming the title of the array
  def rename(list_title)
    @title = list_title
  end
  #Print methods for each of the classes that create a nicely formatted to-do list format.
  def print
  end

  # Save the list to a file, and load the list file if one already exists.
  def save

  end

end

  # Allow multiple users to create their own to-do lists.
  # Add due dates, optional due dates, times, etc.


class Item
  attr_reader :description, :completed_status
  # Initialize item with a description and marked as not complete
  def initialize(item_description) ## add optional deadline here
    @description = item_description
    @completed_status = false
  end

  #Methods for updating the completion status of an item. (If it’s not done, mark it as done, and vice versa.)

  #At least one method that returns a boolean (ex. def completed?).
  def update
    @completed_status = !@completed_status
  end

  def completed?
    @completed_status == true
  end

  # print
  def show
    puts '*' * 40
    puts 'Description: #{@description}'
    puts 'Completion Status #{@completed_status}'
    puts '*' * 40
  end

  def deadline
  end

  def time_left
  end

end
