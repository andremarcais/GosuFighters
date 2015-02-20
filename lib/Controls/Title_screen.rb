require 'Text Input'

class TitleControl

  def initialize(window, next_app)
    @win = window
#    @next_app = next_app
    Button.set_data(@win)
    NewProfile.set_data(@win)
    @bg = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", true)
    @pen = Gosu::Image.new(@win, "media/imgs/lazer pen.png", false)
    @click = Gosu::MsLeft
    @factorX = $width.to_f / @bg.width 
    @factorY = $height.to_f / @bg.height
    @next_app = self
    @play = Button.new(@win , $width/2, $height - 100 , 4 , 0 , "Start") { 
      @next_app = next_app.new(@win, self.class)
    }
    @p1_profile = Button.new(@win , $width/2 - 20 , $height/2 - 125 , 1 , 0 , "Register") {
      
    }
    @p2_profile = Button.new(@win , $width/2 - 300 , $height/2 - 125 , 1 , 0 , "Register") {
      
    }
    @new = Button.new(@win , $width/2 - 50, $height/2 + 100, 1 , 0 , "Create New Profile") {
      @next_app = NewProfile.new(@win)
    }
  end

  def update
    @play.update
    @new.update
    @p1_profile.update
    @p2_profile.update
    # @x = @win.mouse_x
    # @y = @win.mouse_y
    # @pen_over = @x < $width / 2 + 54.5 && @x > $width / 2 - 54.5 && @y > $height - 100
    # if @pen_over && @win.button_down?(Gosu::MsLeft)
    #   return @next_app.new(@win, self.class)
    # end
    return @next_app
  end

  def draw
    @x = @win.mouse_x
    @y = @win.mouse_y
    @bg.draw(0 , 0 , 0 , @factorX , @factorY)
    @pen.draw( @x , @y - @pen.height , 5, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
    @play.draw
    @new.draw
    @p1_profile.draw
    @p2_profile.draw
  end
end
