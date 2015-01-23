class Power_up
attr_reader :x , :y

  def initialize (x , y)
    @rot = rand(360)
    @type = rand(@@imgs.size)
    @x = x
    @y = y
    @vx = rand(-3..3)
    @vy = rand(-3..3)
    @used = false
    @shine_stage = 1
  end

  def radius
    @@imgs[@type].width/2
  end
  
  def move
    @x += @vx
    @y += @vy
    @x %= $width
    @y %= $height

    @vx *= 0.99
    @vy *= 0.99
    @rot = (@rot + 0.25) % 360
  end
  
  def draw
    @@imgs[@type].draw_rot(@x , @y , Z_PLAYER , @rot)
    @@shine[@shine_stage].draw_rot(@x , @y , Z_BAR, 0)
    @time = 0
    @time = @time + 1
    if @time >= 30
      @time = 0
      if @shine_stage < 3
        @shine_stage = @shine_stage + 1
      else
        @shine_stage = 0
      end
    end
  end

  def self.set_img(window)
    @@collect = Gosu::Sample.new(window , "Collect_thing.ogg")
    @@imgs = [
              Gosu::Image.new(window , "Health Power Up.png" , false),
              Gosu::Image.new(window , "Amo Power Up.png" , false),
              Gosu::Image.new(window , "Shieled Power Up.png" , false),
              Gosu::Image.new(window , "Missil Power Up.png" , false),
             ]
    @@shine = [
               Gosu::Image.new(window , "Shine1.png" , false),
               Gosu::Image.new(window , "Shine2.png" , false),
               Gosu::Image.new(window , "Shine3.png" , false),
              ]
  end

  def collect_sound
    @@collect.play
  end

  def type
    return @type
  end
end
