class HpBar
#  def initialize(window, path1, path2, path3, x , y)
  attr_reader :percent
  def initialize(window, path, x , y, right)
    @x, @y = x, y
    @percent = 100.0
    @image = Gosu::Image.new(window, path, false)
    @x -= @image.width if right
  end

  def draw
    @image.draw(@x, @y, 1, @percent/100, Z_BAR)
  end

  def sub(x)
    @percent -= x
    @percent = 0.0 if @percent < 0
  end

  def height
    return @image.height
  end

  def width
    return @image.width
  end
end
