class HpBar
#  def initialize(window, path1, path2, path3, x , y)
  attr_reader :percent
  def initialize(window, path, x , y, right , clip = false, percent = 100.0)
    @window = window
    @x, @y = x, y
    @clip = clip
    @percent = percent
    @image = Gosu::Image.new(window, path, false)
    @x -= @image.width if right
  end

  def draw
    if @clip
      @window.clip_to(@x , @y , @image.width * @percent/100, @image.height) {
        @image.draw(@x, @y, 1, 1, Z_BAR)
      }
    else
      @image.draw(@x, @y, 1, @percent/100, Z_BAR)
    end
  end

  def sub(x)
    @percent -= x
    @percent = 0.0 if @percent < 0
  end

  def set(x)
    @percent = x
  end

  def add(x)
    @percent += x
    @percent = 0.0 if @percent < 0
  end

  def height
    return @image.height
  end

  def width
    return @image.width
  end

  def +_stuff
    @percent = @percent + 10
  end
end
