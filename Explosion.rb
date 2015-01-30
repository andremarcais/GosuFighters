class Explode
  attr_reader :player , :x , :y , :radius , :damage
  def initialize(x , y , s , t , d)   
    @stage = 0
    @x = x
    @y = y
    @size = s
    @time = t
    @damage = d
    @player = nil
    update
  end

  def update
    @img = @@img_set[@stage/@time]
    @radius = @img.width/2 - 4 if @img != nil
    @stage += 1
    return @img.nil?
  end

  def draw
    @img.draw_rot(@x , @y , Z_PLAYER+1 , 0 , 0.5 , 0.5 , @size , @size)
  end

  def explode_sound
    @@explode_sound.play
  end
  
  def self.set_data(w, e)
    @@explode_sound = e
    @@img_set = Gosu::Image.load_tiles(w , "Explosion.png" , 50 , 50 , false)
  end
end
