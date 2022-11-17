require './lib/diary_entry'
class Diary 

  def initialize
    @diary_list = []
    @todo_list = []
    @mobile_numbers = []
  end 

  def display
    @diary_list.map { |entry| entry.contents }
  end 

  def best_entry(wpm,time)
    reading_speed = (wpm * time)
    array_of_options = []
    @diary_list.select do |entry|
      array_of_options << entry.contents if (entry.length_of_entry) <= reading_speed
    end
    raise 'no entries fit your specification' if array_of_options.length == 0
    p array_of_options
    array_of_options.max
  end

  def add(entry)
    @diary_list.push(entry)
    array = entry.contents.split(/[.,\!,\?]/)
    array.each { |sentence| @todo_list << sentence.strip if sentence.include?("#TODO") }
    @mobile_numbers.push(entry.contents.scan(/\d{11}/)) if (entry).contains_mobile_number?
  end 

  def show_todo_list
    @todo_list.uniq
  end 

  def show_mobile_list
    @mobile_numbers.flatten.uniq
  end 

end
