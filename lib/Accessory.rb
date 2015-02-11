class Accessory
  attr_reader :img_set
  def initialize(x , y , vx = 0 , vy = 0 , type = 0)
    @x = x
    @y = y
    @vx = vx + rand(-2.0..2.0)
    @vy = vy + rand(-2.0..2.0)
    @angle = rand(360)
    @type = type
    @img = @@img_set[type]
  end
  
  def move
    @x += @vx
    @y += @vy
    @x %= $width
    @y %= $height

    @vx *= 0.99
    @vy *= 0.99
    @angle = (@vx + @angle) % 360
  end

  def draw
    @img.draw_rot(@x , @y , Z_PLAYER , @angle)
  end
  
  def self.set_data(w)
    @@img_set = Gosu::Image.load_tiles(w , "media/imgs/Ship Peices.png" , 31 , 28 , false)
  end
  def self.nb_parts; @@img_set.size; end
end
