require 'diary' 
require 'diary_entry'

RSpec.describe "diary integration" do

  context "given an empty string as a diary entry" do
    it "returns the diary array" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("")
      diary.add(diary_entry1)
      expect(diary.display).to eq [""]
    end

    it "returns an empty todo list" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("")
      diary.add(diary_entry1)
      expect(diary.show_todo_list).to eq []
    end

    it "returns an empty phone list" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("")
      diary.add(diary_entry1)
      expect(diary.show_mobile_list).to eq []
    end
  end

  context "adds a diary entry created by diary entry class " do
    it "returns the diary array" do
      diary = Diary.new
      diary_entry = DiaryEntry.new("today I wrote some code")
      diary.add(diary_entry)
      expect(diary.display).to eq ["today I wrote some code"]
    end 
  end 

  context "returns 2 diary entries when 2 are added" do
    it "returns the diary array" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("today I wrote some code")
      diary.add(diary_entry1)
      diary_entry2 = DiaryEntry.new("tomorrow I will write some more code")
      diary.add(diary_entry2)
      expect(diary.display).to eq ["today I wrote some code", "tomorrow I will write some more code"]
    end 
  end 

  context "one diary entry that is readable within wpm and time availble" do
    it "returns the entry" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("today " * 60)
      diary.add(diary_entry1)
      expect(diary.best_entry(60,1)).to eq "today " * 60
    end 
  end 

  context "given one diary entry that is not readable within the time" do
    it "analyses entries" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("tomorrow " * 61)
      diary.add(diary_entry1)
      expect{ diary.best_entry(60,1) }.to raise_error "no entries fit your specification"
    end 
  end 

  context "given two diary entries, with only one readable within time" do
    it "analyses entries" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("tomorrow " * 61)
      diary.add(diary_entry1)
      diary_entry2 = DiaryEntry.new("yesterday " * 59)
      diary.add(diary_entry2)
      expect(diary.best_entry(60,1)).to eq "yesterday " * 59
    end
  end

  context "given two diary entries of equal length" do
    it "analyses entries" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("tomorrow " * 60)
      diary.add(diary_entry1)
      diary_entry2 = DiaryEntry.new("yesterday " * 60)
      diary.add(diary_entry2)
      expect(diary.best_entry(60,1)).to eq "yesterday " * 60
    end
  end

  context "given two diary entries of equal length" do
    it "analyses entries" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("Monday " * 58)
      diary.add(diary_entry1)
      diary_entry2 = DiaryEntry.new("Tuesday " * 59)
      diary.add(diary_entry2)
      expect(diary.best_entry(60,1)).to eq "Tuesday " * 59
    end
  end

  context 'given a diary entry not containing any todos' do
    it 'shows any todos' do
      diary = Diary.new
      diary_entry = DiaryEntry.new("saw a fun cat :)")
      diary.add(diary_entry)
      expect(diary.show_todo_list).to eq []
    end
  end

  context 'given a diary entry containing a single todos' do
    it 'shows any todos' do
      diary = Diary.new
      diary_entry = DiaryEntry.new("#TODO find cat")
      diary.add(diary_entry)
      expect(diary.show_todo_list).to eq ["#TODO find cat"]
    end
  end 
  
  context 'given two diary entries only one is a todo' do
    it 'shows any todos' do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("cat gone :(")
      diary_entry2 = DiaryEntry.new("#TODO find cat again")
      diary.add(diary_entry1)
      diary.add(diary_entry2)
      expect(diary.show_todo_list).to eq ["#TODO find cat again"]
    end 
  end

  context 'given two todos' do
    it 'shows any todos' do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("feed cat #TODO")
      diary_entry2 = DiaryEntry.new("#TODO find cat again")
      diary.add(diary_entry1)
      diary.add(diary_entry2)
      expect(diary.show_todo_list).to eq ["feed cat #TODO", "#TODO find cat again"]
    end 
  
  end

  context 'given two identical todos' do
    it 'shows any todos' do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("feed cat #TODO")
      diary_entry2 = DiaryEntry.new("feed cat #TODO")
      diary.add(diary_entry1)
      diary.add(diary_entry2)
      expect(diary.show_todo_list).to eq ["feed cat #TODO"]
    end
  
  end

  context 'given a non empty string with no mobile numbers' do
    it 'shows any mobile numbers' do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("#TODO")
      diary.add(diary_entry1)
      expect(diary.show_mobile_list).to eq []
    end
  
  end
 
  context 'given a diary entry which only contains a phone number' do
    it 'shows any mobile numbers' do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("08001231234")
      diary.add(diary_entry1)
      expect(diary.show_mobile_list).to eq ["08001231234"]
    end
  
  end

  context 'given a diary entry containing two phone numbers' do
    it 'shows any unique mobile numbers' do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("08001231234: old number, 08001234321: new number")
      diary.add(diary_entry1)
      expect(diary.show_mobile_list).to eq ["08001231234", "08001234321"]
    end
  
  end

  context 'given two instances of diary entry, each containing a phone number' do
    it 'shows any unique mobile numbers' do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("08001231235: old number")
      diary_entry2 = DiaryEntry.new("08001234322: new number")
      diary.add(diary_entry1)
      diary.add(diary_entry2)
      expect(diary.show_mobile_list).to eq ["08001231235", "08001234322"]
    end
  
  end

  context 'given two instances of diary entry, both containing the same phone number' do
    it 'shows any unique mobile numbers' do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("08001231237")
      diary_entry2 = DiaryEntry.new("08001231237")
      diary.add(diary_entry1)
      diary.add(diary_entry2)
      expect(diary.show_mobile_list).to eq ["08001231237"]
    end
  
  end

  context "given a complicated succession of diary entries containing multiple sentences, todos, and mobiles" do
    it "just works" do
      diary = Diary.new
      diary_entry1 = DiaryEntry.new("Today was a good day! #TODO stay positive!")
      diary_entry2 = DiaryEntry.new("Michael is 21. He gave me his mobile number 07888999111. Call Michael #TODO")
      diary.add(diary_entry1)
      diary.add(diary_entry2)
      expect(diary.display).to eq ["Today was a good day! #TODO stay positive!", "Michael is 21. He gave me his mobile number 07888999111. Call Michael #TODO"]
      expect(diary.show_todo_list).to eq ["#TODO stay positive", "Call Michael #TODO"]
      expect(diary.show_mobile_list).to eq ["07888999111"]
    end
  end
end 