require 'flame'

class Player
  attr_reader :amo

  def initialize(window, path, hp, amo , shield)
    @image = Gosu::Image.new(window, path, false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @last_fire = 0
    @fire_right = true
    @hp = hp
    @amo = amo
    @dead = false
    @shield = shield
  end

  def hit(b)
    if b.player != self && Gosu::distance(@x, @y, b.x, b.y) < @image.width/2 + b.radius && !@dead
      @hp.sub(5-@shield.percent/25)
      @shield.sub(10) if @shield.percent > 0
      @shield.set(0) if @shield.percent < 0
      b.explode_sound
      @dead = true if @hp.percent <= 0
      true
    else
      false
    end
  end

  def catch(p)
    if Gosu::distance(@x, @y, p.x, p.y) < @image.width/2 + p.radius && !@dead
      p.collect_sound
      if p.type == 0
        @hp.add(rand(10..20))
      elsif p.type == 1
        @amo.add(rand(10..20))
      elsif p.type == 2
        @shield.add(25)
      elsif p.type == 3
        p "Missil will come in next up date"
      end
      return true
    else
      return false
    end
  end
    
  def warp(x, y)
    @x, @y = x, y
  end
  
  def turn_left
    @angle -= 3.5
  end

  def turn_right
    @angle += 3.5
  end

  def accelerate
    return if @dead
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)

    return Flame.new( @x - Gosu::offset_x(@angle, @image.width/2) , @y - Gosu::offset_y(@angle, @image.height/2)  , 0 , 0 )
  end

  def fire(balls, time)
    if time - @last_fire > 100 && @amo.percent > 0 && !@dead
      ball_angle = @angle + (@fire_right ? 60 : -60)
      x, y = @x, @y
      x += Gosu::offset_x(ball_angle, @image.width/2)
      y += Gosu::offset_y(ball_angle, @image.width/2)
      balls << Ball.new(x, y,
                        @vel_x + Gosu::offset_x(@angle, 5),
                        @vel_y + Gosu::offset_y(@angle, 5),
                        time, self)

      @vel_x -= Gosu::offset_x(@angle, 0.1)
      @vel_y -= Gosu::offset_y(@angle, 0.1)      
      @last_fire = time
      @fire_right = !@fire_right
      @amo.sub(1)
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
    if @dead
       @@exploded.draw_rot(@x, @y, 1, 0)
    else
      @image.draw_rot(@x, @y, Z_PLAYER, @angle)
    end
  end

  def self.set_img(img1, img2, fire_sound, explode_sound)
    @@img = img1
    @@exploded = img2
    @@fire_sound = fire_sound
    @@explode_sound = explode_sound
  end
end
