class HpBar
#  def initialize(window, path1, path2, path3, x , y)
  def initialize(window, path, x , y)
    @x, @y = x, y
    @percent = 100.0
    @image = Gosu::Image.new(window, path, false)
  end

  def draw
    @image.draw(@x, @y, 1, @percent/100, Z_BAR)
  end

  def sub(x)
    @percent -= x
    @percent = 0.0 if @percent < 0
  end
end
