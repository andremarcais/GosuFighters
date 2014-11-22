class Player
  def initialize(window, path)
    @image = Gosu::Image.new(window, path, false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @last_fire = 0
    @fire_right = true
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def fire(balls, time)
    if time - @last_fire > 100
      ball_angle = @angle + (@fire_right ? 90 : -90)
      x, y = @x, @y
      x += Gosu::offset_x(ball_angle, @image.width/2)
      y += Gosu::offset_y(ball_angle, @image.width/2)
      balls << Ball.new(x, y,
                        @vel_x + Gosu::offset_x(@angle, 5),
                        @vel_y + Gosu::offset_y(@angle, 5),
                        time)

      @vel_x -= Gosu::offset_x(@angle, 0.1)
      @vel_y -= Gosu::offset_y(@angle, 0.1)      
      @last_fire = time
      @fire_right = !@fire_right
    end
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= $width
    @y %= $height

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, Z_PLAYER, @angle)
  end
end
