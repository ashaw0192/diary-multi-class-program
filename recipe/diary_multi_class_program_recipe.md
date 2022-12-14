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
    #Adds to diary entry list 
  end 

  def display
    #Returns list of diary entries
  end 

  def best_entry (wpm,time)
    #Deliberate choice: returns the SINGLE largest diary entry that can be 
    #read within reading time. Not how many entries can be provided within reading time 
    #wpm is an integer, provided each time the method is called (ie not set somewhere else)
    #time is an integer, provided each time the method is called (ie not set somewhere else)
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

#./lib/diary_entry.rb
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

## 3. Create Examples as Integration Tests and Unit Tests

```Ruby

#__Unit tests: Diary___ 

#1 - prints an empty array [X]

diary = Diary.new 
diary.display # => []

#2 - if no diary entries, best entry method raises error [X]

diary = Diary.new 
diary.best_entry # => "no entries fit your specification"

#___Unit tests: Diary_entry__

#1 - if diary entry is an empty string [X]

diary_entry = DiaryEntry.new("")
diary_entry.contains_todo? # => false
diary_entry.contents # => ""
diary_entry.length_of_entry # => 0
diary_entry.contains_mobile_number? # => false

#2 - Returns a diary entry [X]

diary_entry = DiaryEntry.new("Example entry.")
diary_entry.contents # => "Example entry."

#3 - Calculates entry length [X]

diary_entry = DiaryEntry.new("Example entry.")
diary_entry.length_of_entry # => "2"

#4 - Diary entry containing no todo [X]

diary_entry = DiaryEntry.new("today I wrote some code")
diary_entry.contains_todo? # => false

#5 - Diary entry containing todo [X]

diary_entry1 = DiaryEntry.new("today I need to write some code #TODO.")
diary_entry2 = DiaryEntry.new("today I need #TODO some code.")
diary_entry3 = DiaryEntry.new("#TODO today I need to write some code.")
diary_entry4 = DiaryEntry.new("#TODO: today I need to write some code.")
diary_entry5 = DiaryEntry.new("(#TODO) today I need to write some code.")
diary_entry1.contains_todo? # => true
diary_entry2.contains_todo? # => true
diary_entry3.contains_todo? # => true
diary_entry4.contains_todo? # => true
diary_entry5.contains_todo? # => true

#6 - Diary entries containing no, or the wrong formatted, todo [X]

diary_entry1 = DiaryEntry.new("today I need todo something, i'm so bored.")
diary_entry3 = DiaryEntry.new("#todo today I need to write some code.")
diary_entry4 = DiaryEntry.new("#TO DO today I cold.")
diary_entry5 = DiaryEntry.new("#TO-DO I need to write some code.")
diary_entry6 = DiaryEntry.new("#TODO")
diary_entry1.contains_todo? # => false
diary_entry3.contains_todo? # => false
diary_entry4.contains_todo? # => false
diary_entry5.contains_todo? # => false
diary_entry6.contains_todo? # => false

# .... .split(".", "?", "!").select{&:include?( "#TODO" )} .... ?

#7 Given an entry that contains a string containing only letters [X]

diary_entry1 = DiaryEntry.new("today I need todo something, i'm so bored.")
diary_entry1.contains_mobile_number? # => false

#8 Entry contains only a number(s) but NOT a phone number, returns false [x]

diary_entry1 = DiaryEntry.new("1234")
diary_entry1.contains_mobile_number? # => false

#9 Entry contains a number(s) and text but NOT a phone number, returns false [X]

diary_entry1 = DiaryEntry.new("today I coded for 8 hours")
diary_entry1.contains_mobile_number? # => false

#10 Diary entry ONLY contains phone number [X]

diary_entry1 = DiaryEntry.new("08001231234")
diary_entry1.contains_mobile_number? # => true

#11 Entry contains phone number and text [X]

diary_entry1 = DiaryEntry.new("jon mob: 08001231234")
diary_entry1.contains_mobile_number? # => true

#12 entry contains text, non phone numbers and phone num [X]

diary_entry1 = DiaryEntry.new("jon10 mob 2: 08001231234")
diary_entry1.contains_mobile_number? # => true

#13 entry contains a phone number with text within the 11 digits [X]

diary_entry1 = DiaryEntry.new("(08)001231234")
diary_entry1.contains_mobile_number? # => false

#14 entry contains a number longer than 11 digits INCOMPLETE

diary_entry1 = DiaryEntry.new("8123456789123")
diary_entry1.contains_mobile_number? # => false

#15 entry contains a 11 digit phone number within a word [X]

diary_entry1 = DiaryEntry.new("(01234567893)")
diary_entry1.contains_mobile_number? # => true

#16 11 digits in a row with white space in between [X]

diary_entry1 = DiaryEntry.new("0 1 2 3 4 5 6 7 8 9 3")
diary_entry1.contains_mobile_number? # => false

#17 entry contains a non phone number digit followed by a phone number [X]

diary_entry1 = DiaryEntry.new("here is Jon's phone number 2022 01234567893")
diary_entry1.contains_mobile_number? # => true

#__Integration tests___ 

#1 - adds a diary entry created by diary entry class [X]

diary = Diary.new
diary_entry = DiaryEntry.new("today I wrote some code")
diary.add(diary_entry)
diary.display # => ["today I wrote some code"]


#2 - returns 2 diary entries when 2 are added [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("today I wrote some code")
diary.add(diary_entry1)
diary_entry2 = DiaryEntry.new("tomorrow I will write some more code")
diary.add(diary_entry2)
diary.display # => ["today I wrote some code", "tomorrow I will write some more code"]

#3 - given one diary entry that is readable within wpm and time availble, returns entry [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("today " * 60)
diary.add(diary_entry1)
diary.best_entry(60,1) # => "today " * 60

#4 - given one diary entry that is not readable within the time, raises error [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("tomorrow " * 61)
diary.add(diary_entry1)
diary.best_entry(60,1) # => "no entries fit your specification"

#5 - given two diary entries, with only one readable within time, return that entry [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("tomorrow " * 61)
diary.add(diary_entry1)
diary_entry2 = DiaryEntry.new("yesterday " * 59)
diary.add(diary_entry2)
diary.best_entry(60,1) # => "yesterday " * 59"

#6 - given two diary entries of equal length return only one entry [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("tomorrow " * 60)
diary.add(diary_entry1)
diary_entry2 = DiaryEntry.new("yesterday " * 60)
diary.add(diary_entry2)
diary.best_entry(60,1) # => returns the last entry

#7 - given two diary entries readable within the time, ensure that [X]
  #the larger of the two is returned

diary = Diary.new
diary_entry1 = DiaryEntry.new("Monday " * 58)
diary.add(diary_entry1)
diary_entry2 = DiaryEntry.new("Tuesday " * 59)
diary.add(diary_entry2)
diary.best_entry(60,1) # => "Tuesday " * 59 

#8 - given an empty string as a diary entry, adds it to diary list and returns it [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("")
diary.add(diary_entry1)
diary.display # => [""]

#9 - given a diary contents containing no todos [X]

diary = Diary.new
diary_entry = DiaryEntry.new("")
diary.show_todo_list # => []

#10 - given a non todo [X]

diary = Diary.new
diary_entry = DiaryEntry.new("saw a fun cat :)")
diary.show_todo_list # => []

#11 - given a todo [X]

diary = Diary.new
diary_entry = DiaryEntry.new("#TODO find cat")
diary.show_todo_list # => ["#TODO find cat"]

#12 - given two diary entries only one is a todo [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("cat gone :(")
diary_entry2 = DiaryEntry.new("#TODO find cat again")
diary.show_todo_list # => ["#TODO find cat again"]

#13 - given two todos [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("feed cat #TODO")
diary_entry2 = DiaryEntry.new("#TODO find cat again")
diary.add(diary_entry1)
diary.add(diary_entry2)
diary.show_todo_list # => ["feed cat #TODO", "#TODO find cat again"]

#14 - given two identical todos [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("feed cat #TODO")
diary_entry2 = DiaryEntry.new("feed cat #TODO")
diary.add(diary_entry1)
diary.add(diary_entry2)
diary.show_todo_list # => ["feed cat #TODO"]

#15 - given a diary entry of an empty string, show mobile numbers returns an empty list [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("")
diary.add(diary_entry1)
diary.show_mobile_list # => []

#16 - given a non empty string wherein contains mobile number is false [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("#TODO")
diary.add(diary_entry1)
diary.show_mobile_list # => []

#17 - given a diary entry which only contains a phone number [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("08001231234")
diary.add(diary_entry1)
diary.show_mobile_list # => ["08001231234"]

#18 - given a diary entry containing two phone numbers [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("08001231234: old number, 08001234321: new number")
diary.add(diary_entry1)
diary.show_mobile_list # => ["08001231234", "08001234321"]

#19 - given two instances of diary entry, each containing a phone number [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("08001231235: old number")
diary_entry2 = DiaryEntry.new("08001234322: new number")
diary.add(diary_entry1)
diary.add(diary_entry2)
diary.show_mobile_list # => ["08001231235", "08001234322"]

#20 - given two instances of diary entry, both containing the same phone number [X]

diary = Diary.new
diary_entry1 = DiaryEntry.new("08001231237")
diary_entry2 = DiaryEntry.new("08001231237")
diary.add(diary_entry1)
diary.add(diary_entry2)
diary.show_mobile_list # => ["08001231237"]

#21 - given a complicated succession of diary entries containing multiple sentences, todos, and mobiles [X]
diary = Diary.new
diary_entry1 = DiaryEntry.new("Today was a good day! #TODO stay positive!")
diary_entry2 = DiaryEntry.new("Michael is 21. He gave me his mobile number 07888999111. Call Michael #TODO")
diary.add(diary_entry1)
diary.add(diary_entry2)
diary.display # => ["Today was a good day! #TODO stay positive!", "Michael is 21. He gave me his mobile number 07888999111. Call Michael #TODO"]
diary.show_todo_list # => ["#TODO stay positive", "Call Michael #TODO"]
diary.show_mobile_list # => ["07888999111"]
```

## 4. Implement the Behaviour

For each example you create as a test, implement the behaviour that allows the class to behave according to your example.

Then return to step 3 until you have addressed the problem you were given. You may also need to revise your design, for example if you realise you made a mistake earlier.