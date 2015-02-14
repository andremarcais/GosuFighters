class TitleControl

  def initialize(window, next_app)
    @win = window
    @next_app = next_app
    @bg = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", true)
    @pen = Gosu::Image.new(@win, "media/imgs/lazer pen.png", false)
    @click = Gosu::MsLeft
    @factorX = $width.to_f / @bg.width 
    @factorY = $height.to_f / @bg.height
    
  end

  def update
    @x = @win.mouse_x
    @y = @win.mouse_y
    @pen_over = @x < $width / 2 + 54.5 && @x > $width / 2 - 54.5 && @y > $height - 100
    if @pen_over && @win.button_down?(Gosu::MsLeft)
      return @next_app.new(@win, self.class)
    end
    return self
  end

  def draw
    @x = @win.mouse_x
    @y = @win.mouse_y
    @bg.draw(0 , 0 , 0 , @factorX , @factorY)
    @pen.draw( @x , @y - @pen.height , 1, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
  end
end
