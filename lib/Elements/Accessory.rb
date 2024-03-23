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
    @time = 0
  end
  
  def move(flames)
    @x += @vx
    @y += @vy
    @x %= $width
    @y %= $height

    @time += 1

    flames << Flame.new( @x , @y , rand(-0.3..0.3) , rand(-0.3..0.3) , 3 ) if @time % rand(30..70) == 0

    @vx *= 0.99
    @vy *= 0.99
    @angle = (@vx + @angle) % 360
  end

  def draw
    @img.draw_rot(@x , @y , Z_PLAYER , @angle)
  end
  
  def self.set_data(w)
    @@img_set = Gosu::Image.load_tiles(w , "media/imgs/Ship Peices.png" , 31 , 28 , false) if $three_dimension == false
    @@img_set = Gosu::Image.load_tiles(w , "media/imgs/Ship Peices (copy).png" , 31 , 28 , false) if $three_dimension == true
  end
  def self.nb_parts; @@img_set.size; end
end
