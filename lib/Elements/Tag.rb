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

  def draw( size = 0.75 )
    @img.draw(@x , @y , Z_BAR , size , size)
    @font.draw( "#{@num} X" , @x , @y , Z_BAR + 1)
  end
  
end
