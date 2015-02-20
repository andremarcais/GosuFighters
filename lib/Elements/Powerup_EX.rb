class Powerup_EX
  attr_reader :x , :y , :type
  AMAX = 1.0/3.0
  def initialize (x , y)
    @type = "EX"
    @rot = rand(360)
    @x = x
    @y = y
    @vx = rand(-3..3)
    @vy = rand(-3..3)
    @ax = 0
    @ay = 0
    @used = false
    @stage = 0
    @shine_stage = 1
    @timer = 0
  end

  def radius
    @@imgs[0].width/2
  end
  
  def move(p1 , p2)
    @timer += 1
    
    dist1 = Gosu::distance(p1.x , p1.y , @x , @y)
    dist2 = Gosu::distance(p2.x , p2.y , @x , @y)
    
    @ax = (@x - p1.x)/(dist1*(AMAX + dist1)) + (@x - p2.x)/(dist2*(AMAX + dist2))
    @ay = (@y - p1.y)/(dist1*(AMAX + dist1)) + (@y - p2.y)/(dist2*(AMAX + dist2))

    @vx += @ax
    @vy += @ay

    @vx *= 0.999999
    @vy *= 0.999999
    
    @x += @vx
    @y += @vy

    @x %= $width
    @y %= $height

    @rot = (@rot + 1) % 360
  end
  
  def draw
      @stage %= @@imgs.size
      @shine_stage %= @@shine.size
      
      @@imgs[@stage].draw_rot(@x , @y , Z_PLAYER , @rot)
      @@shine[@shine_stage].draw_rot(@x , @y , Z_PLAYER + 1, 0 , 0.5 , 0.5 , 17 , 17)
    if @timer > 7.5
      @stage += 1 
      @shine_stage += 1
      @timer = 0
    end
  end


  def self.set_data(window)
    @@collect = Gosu::Sample.new(window , "media/sounds/Collect_EX.ogg")
    @@shine = Gosu::Image.load_tiles(window , "media/imgs/Shine_EX.png" , 200 , 100 , false)
    @@imgs = Gosu::Image.load_tiles(window , "media/imgs/Powerup_EX.png" , 50 , 50 , false)
  end

  def collect_sound
    @@collect.play
  end
end
