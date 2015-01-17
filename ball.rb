class Ball
  attr_reader :x, :y, :player

  def self.radius
    @@img.width/2
  end

  def radius
    @factor * @@img.width/2
  end

  def initialize(x ,y, vx, vy, time, player)
    @x, @y, @vx, @vy = x, y, vx, vy
    @creation_time = time
    @factor = 1
    @age = 0
    @player = player
    @@fire_sound.play
  end

  def move(time)
    @x = (@x + @vx) % $width
    @y = (@y + @vy) % $height
    @age = time - @creation_time
    @factor = 1.0 - @age.to_f / 5000
    return @age > 3000
  end

  def draw(time)
    if @age > 2750
      @@exploded.draw_rot(@x, @y, 1, 0)
    else
      @@img.draw_rot(@x, @y, Z_PLAYER, 0, 0.5, 0.5, @factor, @factor)
    end
  end

  def explode_sound
    @@explode_sound.play
  end

  def self.set_img(img1, img2, fire_sound, explode_sound)
    @@img = img1
    @@exploded = img2
    @@fire_sound = fire_sound
    @@explode_sound = explode_sound
  end
end
