# DIARY MULTI-CLASS PROGRAM RECIPE

## 1. Describe the Problem

* As a user
So that I can record my experiences
I want to keep a regular diary

* As a user
So that I can reflect on my experiences
I want to read my past diary entries

* As a user
So that I can reflect on my experiences in my busy day
I want to select diary entries to read based on how much time I have and my reading speed

* As a user
So that I can keep track of my tasks
I want to keep a todo list along with my diary

* As a user
So that I can keep track of my contacts
I want to see a list of all of the mobile phone numbers in all my diary entries

take aways - 
1) first class = diary: input diary entries, save diary entries
2) second class = diary entries: output
3) analyse diary entries given users criteria(wpm, readspeed)
4) third class = todo: input todo entries, save todo, output todo
5) extract phone numbers from diary entries

key words -
1) n - diary, diary entries
   v - record, keep
2) n - diary entries
   v - read
3) n - time, reading speed, diary entries
   v - select 
4) n - tasks, diary entries 
   v - keep, track
5) n - mobile numbers, list, diary entries
   v - keep, track, list

## 2. Design the Class System

```Ruby
#.lib/diary.rb
class Diary 

  public 

  def initialize
   @diary_list = []
   @todo_list = []
   @mobile_numbers = []
  end 

  def add (entry)
  #Instance of diary_entry class
  #Returns Nothing 
  # Adds to diary entry list 
  end 

  def display
  #Returns list of diary entries

  end 

  def best_entry (wpm,time)

  # Deliberate choice: returns the SINGLE largest diary entry that can be 
  #read within reading time. Not how many entries can be provided within reading time 
  # wpm is an integer, provided each time the method is called (ie not set somewhere else)
  # time is an integer, provided each time the method is called (ie not set somewhere else)


  end 

  def show_todo_list 
    #returns todo list
  end

  def show_mobile_numbers
    #returns a list of mobile numbers taken from entries
  end

  private

  def add_todo
    #add entry to todo list if it contains todo
  end

  def add_mobile
    #entracts mobile number and adds it to mobile number list
  end

end 

class DiaryEntry 

  def ininitialize (text)
    #text is a string that contains an entry for the diary 
  end 

  def contents 
    #returns text 
  end 

  def length_of_entry
    #return word count as an integer
  end

  def contains_todo?
    #returns true/false depending on whether todo present
  end

  def contains_mobile_number?
    #returns true/false depending on whether entry contains a valid mobile number
  end

end 

```

## 3. Create Examples as Integration Tests

Create examples of the classes being used together in different situations and combinations that reflect the ways in which the system will be used.

Encode one of these as a test and move to step 4.

## 4. Create Examples as Unit Tests

Create examples, where appropriate, of the behaviour of each relevant class at a more granular level of detail.

Encode one of these as a test and move to step 5.

## 5. Implement the Behaviour

For each example you create as a test, implement the behaviour that allows the class to behave according to your example.

Then return to step 3 until you have addressed the problem you were given. You may also need to revise your design, for example if you realise you made a mistake earlier.