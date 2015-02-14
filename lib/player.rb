class Player
  attr_reader :amo , :x , :y, :angle , :vel_x , :vel_y , :damage , :dead

  def initialize(window, path, hp, amo , shield , nb_miss)
    @img_set = Gosu::Image.load_tiles(window , path , 50 , 50 , false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @last_fire = 0
    @fire_right = true
    @hp = hp
    @amo = amo
    @dead = false
    @shield = shield
    @nb_missils = nb_miss
    @damage = 25
    @last_fire_missil = 0
    @last_e_f = 0
    @part_count = 0
    @parts = []
    @timer = 0
    update_img
  end

  def to_s
    "<Player #{@x} #{@y}>"
  end

  def radius
    return @image.width/2
  end

  def update_img
    @image = @img_set[@img_set.size - 1 - (@img_set.size * [@hp.percent, 99].min / 100.0).floor]
  end

  def hit(b, boom = nil , parts = nil)
    if b.player != self && Gosu::distance(@x, @y, b.x, b.y) < @image.width/2  + b.radius && !@dead
      boom << Explode.new(b.x + b.radius  , b.y + b.radius , 0.5 , 1 , 0) if !boom.nil?
      @hp.sub([b.damage-@shield.percent/25, 0].max)
      @shield.sub(10) if @shield.percent > 0
      @shield.set(0) if @shield.percent < 0
      b.explode_sound
      if @hp.percent <= 0
        @dead = true 
        boom << Explode.new(@x , @y , 2 , 4 , 0) if !boom.nil?
        Accessory.nb_parts.times { |part_count|
          parts << Accessory.new(@x , @y , @vel_x + rand(1.0..3.0) , @vel_y + rand(1.0..3.0) , part_count)
        }
      end
      update_img
      true
    else
      false
    end
  end

  def boom(b , window)
    return b.player != self && Gosu::distance(@x, @y, b.x, b.y) < @image.width/2 + b.radius && !@dead
  end

  def catch(p)
    if Gosu::distance(@x, @y, p.x, p.y) < @image.width/2 + p.radius && !@dead
      p.collect_sound
      if p.type == 0
        @hp.add(rand(10..20))
        update_img
      elsif p.type == 1
        @amo.add(rand(10..20))
      elsif p.type == 2
        @shield.add(25)
      elsif p.type == 3
        @nb_missils += 1
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
    if @hp.percent > 0
      @angle -= 3.5
    end
  end

  def turn_right
    if @hp.percent > 0
        @angle += 3.5
    end
  end

  def accelerate(flames)
    return if @dead
    if rand(@hp.percent - 10..@hp.percent) <= rand(0..50)
      if @last_e_f > 120
        @@engine_fail[rand(@@engine_fail.size)].play
        @last_e_f = 0
      end
      @last_e_f += 1
    else
      
      @vel_x += Gosu::offset_x(@angle, 0.5)
      @vel_y += Gosu::offset_y(@angle, 0.5)
      
      flames << Flame.new( @x - Gosu::offset_x(@angle, @image.width/2) , @y - Gosu::offset_y(@angle, @image.height/2)  , 0 , 0 )
    end
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

  def fire_missil(m , t , time)
    if time - @last_fire_missil > 1000 && @nb_missils.num > 0 && !@dead
      return if @nb_missils == 0
      @nb_missils -= 1
      m << Missil.new(self, t)
      @last_fire_missil = time
    end
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= $width
    @y %= $height

    @last_e_f += 1

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw(flames)
    if @dead
      @@exploded.draw_rot(@x, @y, 1, @angle)
      @parts.each{|s| s.draw} if @parts != nil
      flames << Flame.new( @x - rand(-(@image.width/2)..@image.width)/2 , @y - rand(-(@image.width/2)..@image.width)/2 , rand(0.0..0.2) , rand(0.0..0.2) ) if @timer % rand(5..40) == 0
    else
      @image.draw_rot(@x, @y, Z_PLAYER, @angle)
    end
    @timer += 1
    @nb_missils.draw
 #   @@missil_icon.draw($width - (@@missil_icon.width + 14) , @hp.height + @amo.height + @shield.height + 4 , Z_BAR)

#    @@font.draw( "X #{@nb_missils}" , 14 + @@missil_icon.width , @hp.height + @amo.height + @shield.height + 4 , Z_BAR) 
  end

  def self.set_img(img1, img2, fire_sound, explode_sound , e_f , mi , font)
    @@img = img1
    @@exploded = img2
    @@fire_sound = fire_sound
    @@explode_sound = explode_sound
    @@engine_fail = e_f
#    @@missil_icon = mi
    @@font = font
  end
end
