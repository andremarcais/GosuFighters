class Ball
  def initialize(x ,y, vx, vy)
    @x, @y, @vx, @vy = x, y, vx, vy
    @age = 0
  end

  def move
    @x = (@x + @vx) % $width
    @y = (@y + @vy) % $height
    @age += 1
  end

  def draw
    @@img.draw(@x, @y, 1)
  end

  def self.set_img(img)
    @@img = img
  end
end
