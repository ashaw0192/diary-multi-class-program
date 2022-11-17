require 'diary_entry'

RSpec.describe DiaryEntry do

    context "diary entry is an empty string" do
      
      it "returns an empty string" do 
        diary_entry = DiaryEntry.new("")
        expect(diary_entry.contents).to eq ""
      end 

      it "returns length of an empty string" do 
        diary_entry = DiaryEntry.new("")
        expect(diary_entry.length_of_entry).to eq 0
      end 

      it "evaluates whether empty string contains to do" do 
        diary_entry = DiaryEntry.new("")
        expect(diary_entry.contains_todo?).to eq false
      end 

      it "evaluates whether empty string contains phone number" do 
        diary_entry = DiaryEntry.new("")
        expect(diary_entry.contains_mobile_number?).to eq false
      end 
      
    end 

    context "diary entry has a string" do 

      it "Returns a diary entry with a string in it" do 
        diary_entry = DiaryEntry.new("Example entry.")
        expect(diary_entry.contents).to eq "Example entry."
      end 

      it "Returns count of words of string as an integer" do
        diary_entry = DiaryEntry.new("Example entry.")
        expect(diary_entry.length_of_entry).to eq 2
      end

    end

  describe "contains_todo? method" do

    context "Diary entry is a string that doesn't contain a todo" do

      it "returns false" do
        diary_entry = DiaryEntry.new("today I wrote some code")
        expect(diary_entry.contains_todo?).to eq false
      end

    end

    context "Diary entry is a string containing a valid todo" do

      it "returns true when #TODO is at the end of a string" do
        diary_entry1 = DiaryEntry.new("today I need to write some code #TODO.")
        expect(diary_entry1.contains_todo?).to eq true
      end

      it "retruns true when #TODO is in the middle of the string" do
        diary_entry2 = DiaryEntry.new("today I need #TODO some code.")
        expect(diary_entry2.contains_todo?).to eq true
      end

      it "returns true when #TODO st the start of a string" do
        diary_entry3 = DiaryEntry.new("#TODO today I need to write some code.")
        expect(diary_entry3.contains_todo?).to eq true
      end

      it "returns true when #TODO is followed immediately
      by punctuation that isnt a sentence break" do
        diary_entry4 = DiaryEntry.new("#TODO: today I need to write some code.")
        expect(diary_entry4.contains_todo?).to eq true
      end

      it "returns true when #TODO is surrounded" do
        diary_entry5 = DiaryEntry.new("(#TODO) today I need to write some code.")
        expect(diary_entry5.contains_todo?).to eq true
      end

    end

    context "diary entry is a string containing an invalid todo" do

      it "returns false" do
        diary_entry1 = DiaryEntry.new("today I need todo something, i'm so bored.")
        diary_entry3 = DiaryEntry.new("#todo today I need to write some code.")
        diary_entry4 = DiaryEntry.new("#TO DO today I cold.")
        diary_entry5 = DiaryEntry.new("#TO-DO I need to write some code.")
        diary_entry6 = DiaryEntry.new("#TODO")
        expect(diary_entry1.contains_todo?).to eq false
        expect(diary_entry3.contains_todo?).to eq false
        expect(diary_entry4.contains_todo?).to eq false
        expect(diary_entry5.contains_todo?).to eq false
        expect(diary_entry6.contains_todo?).to eq false
      end

    end

  end

  describe "contains_mobile_number? method" do

    context "diary entry contains no numbers only letters" do

      it "evalutes the string" do 
        diary_entry1 = DiaryEntry.new("today I need todo something, i'm so bored.")
        expect(diary_entry1.contains_mobile_number?).to eq false
      end

    end

    context "diary entry contains only a valid phone number" do
      it "evaluates the string" do
        diary_entry1 = DiaryEntry.new("08001231234")
        expect(diary_entry1.contains_mobile_number?).to eq true
      end
    end

    context 'Entry contains only a number(s) but NOT a phone number' do 
      it 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("1234")
        expect(diary_entry1.contains_mobile_number?).to eq false
      end 
    end 

    context 'Entry contains a number(s) and text but NOT a phone number' do
      it 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("today I coded for 8 hours")
        expect(diary_entry1.contains_mobile_number?).to eq false
      end 
    end 

    context 'Entry contains phone number and text' do
      it 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("jon mob: 08001231234")
        expect(diary_entry1.contains_mobile_number?).to eq true
      end 
    end 

    context 'entry contains text, non phone numbers and phone num' do
      it 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("jon10 mob 2: 08001231234")
        expect(diary_entry1.contains_mobile_number?).to eq true
      end 
    end 

    context 'entry contains a phone number with text within the 11 digits' do
      it 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("(08)001231234")
        expect(diary_entry1.contains_mobile_number?).to eq false
      end 
    end 

    context 'entry contains a number longer than 11 digits' do
      xit 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("8123456789123")
        expect(diary_entry1.contains_mobile_number?).to eq false
      end 
    end 

    context 'entry contains a 11 digit phone number within a word' do
      it 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("(01234567893)")
        expect(diary_entry1.contains_mobile_number?).to eq true
      end 
    end

    context '11 digits in a row with white space in between ' do
      it 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("0 1 2 3 4 5 6 7 8 9 3")
        expect(diary_entry1.contains_mobile_number?).to eq false
      end 
    end

    context 'entry contains a non phone number digit followed by a phone number' do
      it 'evaluates the string' do
        diary_entry1 = DiaryEntry.new("here is Jon's phone number 2022 01234567893")
        expect(diary_entry1.contains_mobile_number?).to eq true
      end 
    end

  end


end 