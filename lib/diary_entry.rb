class DiaryEntry
  def initialize(text)
    @text = text
  end 

  def contents 
    @text
  end 

  def length_of_entry
    @text.split.length
  end 

  private

  def contains_todo?
    return false if @text.split.length == 1
    @text.include?("#TODO")
  end 

  def contains_mobile_number?
    !@text.scan(/\d{11}/).empty?  
  end 

end 
