class HpBar
  def initialize(window, path, x , y)
    @x, @y = x, y
    @percent = 100.0
    @image = Gosu::Image.new(window, path, false)
  end

  def draw
    @image.draw(@x, @y, 1, @percent/100, 1)
  end
end
