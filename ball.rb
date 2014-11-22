class Ball
  def initialize(x ,y, vx, vy, time)
    @x, @y, @vx, @vy = x, y, vx, vy
    @creation_time = time
  end

  def move(time)
    @x = (@x + @vx) % $width
    @y = (@y + @vy) % $height
    return time - @creation_time > 3000
  end

  def draw(time)
    age = time - @creation_time
    if age > 2750
      @@exploded.draw_rot(@x, @y, 1, 0)
    else
       factor = 1.0 - age.to_f / 5000
      @@img.draw_rot(@x, @y, Z_PLAYER, 0, 0.5, 0.5, factor, factor)
    end
  end

  def self.set_img(img1, img2)
    @@img = img1
    @@exploded = img2
  end
end
