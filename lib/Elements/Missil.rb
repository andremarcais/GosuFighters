require 'flame'
require 'Explosion'

class Missil
  attr_reader :hp , :x , :y, :angle, :player , :range , :target

  def initialize(player , target)
    @x = player.x + Gosu::offset_x(player.angle , player.radius)
    @y = player.y + Gosu::offset_y(player.angle , player.radius)
    @vel = 5 + Gosu::distance(0, 0, player.vel_x , player.vel_y)
    @angle = player.angle
    @hp = 15
    @player = player
    @target = target
    @fuel = 1200
  end
  
  def radius; @@img.width; end
  def height; @@img.height; end
  def damage; 25; end
  
  def turn_left
    @angle -= 2.5
  end
  
  def turn_right
    @angle += 2.5
  end
  
  def move(flames)
    if @fuel > 0
      target_angle = Gosu::angle(@x , @y , @target.x , @target.y)
      if Gosu::angle_diff(@angle , target_angle) > 0
        turn_right
      else
        turn_left
      end
      
      @fuel -= 1
      
      @vel_x = Gosu::offset_x(@angle, @vel)
      @vel_y = Gosu::offset_y(@angle, @vel)
      flames << Flame.new( @x - Gosu::offset_x(@angle, @@img.height/2) , @y - Gosu::offset_y(@angle, @@img.height/2)  , rand(0.0..1.0)+(-@vel_y)/3 , rand(0.0..1.0)+(-@vel_x)/3 )
    else
      @vel_x *= 0.99
      @vel_y *= 0.99
    end
      
    @x += @vel_x
    @y += @vel_y
    @x %= $width
    @y %= $height
  end

  def explode_sound
    @@explode_sound.play
  end

  def hit(b, boom)
    if Gosu::distance(@x, @y, b.x, b.y) < @@img.width/2 + b.radius
      boom << Explode.new(b.x + b.radius  , b.y + b.radius , 0.5 , 1 , 0)
      @hp -= b.damage
      b.explode_sound
      true
    else
      false
    end
  end

  def draw
    @@img.draw_rot(@x, @y, Z_PLAYER, @angle)
  end

  def self.set_img(window , explode_sound)
    @@img = Gosu::Image.new(window, "media/imgs/Missil.png", false)
    @@explode_sound = explode_sound
  end
end
