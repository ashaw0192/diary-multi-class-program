require 'diary'

RSpec.describe Diary do
  
  context "no diary entries added" do 
    
    it "prints an empty array" do 

      diary = Diary.new 
      expect(diary.display).to eq []

    end 

  end 

  context 'if no diary entries,' do
    it 'raises error when best entry method called' do
      diary = Diary.new 
      expect{diary.best_entry}.to raise_error 'no entries fit your specification'
    end 
  end 
  
end
