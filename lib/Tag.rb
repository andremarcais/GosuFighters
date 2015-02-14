class Tag
  attr_accessor :num
  def initialize(img , num , x , y , font)
    @img = img
    @num = num
    @x , @y = x , y
    @font = font
  end

  def +(add)
    @num += add
    self
  end 

  def -(sub)
    @num -= sub
    self
  end 

  def draw
    @img.draw(@x , @y , Z_BAR , 0.75 , 0.75)
    @font.draw( "#{@num} X" , @x , @y , Z_BAR + 1)
  end
  
end
