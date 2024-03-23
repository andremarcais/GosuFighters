class Button
  attr_reader :image
  def initialize(win , x , y , scale , type = 0 , text = "button" , path = nil , &action)
#    @imgs = path.load_tiles()
    @win = win
    @x = x
    @y = y
    if path != nil
      @image = Gosu::Image.new(@win , path , false)
    else
      @image = Gosu::Image.from_text(@win , text , @@font.name , 25)
      @text = text
    end
    @hovering = false
    @click = false
    @action = action
    @scale = scale
  end
  
  def update(text = nil)
    mx = @win.mouse_x
    my = @win.mouse_y

    @action[] if @click && !@win.button_down?(Gosu::MsLeft)

    @hovering = my >= @y - (@image.height/3) * @scale && my <@y+(@image.height/3) * @scale && mx >= @x - (@image.width/2) * @scale && mx < @x + (@image.width/2) * @scale
    @click = @hovering && @win.button_down?(Gosu::MsLeft)

    if !text.nil? && text != @text
      @image = Gosu::Image.from_text(@win , text , @@font.name , 25)
      @text = text
    end
  end
  
  def draw
    factor = @hovering ? 1.5 * @scale : 1 * @scale
    color = @click ? Gosu::Color::GRAY : Gosu::Color::WHITE
    @image.draw_rot(@x , @y , 2, 0 , 0.5 , 0.5 , factor , factor , color)
  end

  def self.set_data(win)
    @@font = Gosu::Font.new(win , Gosu::default_font_name , 25)
  end
end
