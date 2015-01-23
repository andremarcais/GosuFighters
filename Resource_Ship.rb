require 'Power_Up'

class R_Ship
  def initialize
    @last_give = 0
    @items = 5
    @x = -100
    @y = -100
    perimeter = 2 * $width + 2 * $height
    spawn_num = rand(perimeter)
    if spawn_num < $width
      @angle = rand(90..270)
      @y = 0
      @x = spawn_num
    elsif spawn_num < $width + $height
      @angle = rand(180..360)
      @x = $width - 1
      @y = spawn_num - $width
    elsif spawn_num < 2 * $width + $height
    @angle = rand(-90..90)
      @y = $height - 1
      @x = spawn_num - ($width + $height)
    else
      @angle = rand(0..180)
      @x = 0
      @y = spawn_num - (2 * $width + $height)
    end

    @vel_x = Gosu::offset_x(@angle, 2)
    @vel_y = Gosu::offset_y(@angle, 2)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    return !(@x >= $width || @y >= $height || @x < 0 || @y < 0)
  end

  def draw
    @@image.draw_rot(@x, @y, Z_PLAYER, @angle)
  end

  def r_drop
    Power_up.new(@x , @y)
  end

  def self.set_img(image)
    @@image = image
  end
end
