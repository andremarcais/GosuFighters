class Flame
  MAX_AGE = 30
  attr_reader :age
  def initialize( x , y , vy , vx)
    @angle = 0.0
    @vel_x = vx
    @vel_y = vy
    @x = x
    @y = y 
    @age = 0
    @color = Gosu::Color.new(0xffffffff)
  end

  def self.set_img(window)
    @@img = [
             Gosu::Image.new(window, "flame.png" , false)
            ]
  end

  def update
    @age += 1
    return true if @age > MAX_AGE
    @color.alpha = 255 * (MAX_AGE - @age).to_f / MAX_AGE
    @angle += (@vel_x + @vel_y / 2)
    
    @x += @vel_x
    @y += @vel_y
    
    @vel_x = @vel_x/0.99
    @vel_y = @vel_y/0.99
    return false
  end

  def draw
    @@img[0].draw_rot(@x , @y , Z_BAR , @angle , 0.5 , 0.5 , 1 , 1 , @color)
  end

end
