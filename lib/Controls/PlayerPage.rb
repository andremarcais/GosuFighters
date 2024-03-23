class PlayerPage

  def initialize(window, app_stack , p)
    @p = p
    @win = window
    @bg = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", true)
    @factorX = $width.to_f / @bg.width 
    @factorY = $height.to_f / @bg.height
    @pen = Gosu::Image.new(@win, "media/imgs/lazer pen.png", false)
    @click = Gosu::MsLeft
    @shop = Button.new(@win , $width/2 - 100 , $height/1.75 , 1 , 0 , "Shop") {
      app_stack << Shop.new(@win , app_stack , @p)
    }
    @profile = Button.new(@win , $width/2 - 100 , $height/2 , 1 , 0 , "Register") {
      app_stack << Register.new(@win , app_stack , @p)
    }
    @garage = Button.new(@win , $width/2 - 100 , $height/3 , 1 , 0 , "Garage") {
      app_stack << Garage.new(@win , app_stack , @p)
    }
    @new = Button.new(@win , $width/2 - 50, $height/4 + 125 , 1 , 0 , "Create New Profile") {
      app_stack << NewProfile.new(@win , app_stack)
    }
    @done = Button.new(@win , $width/2, $height - 100 , 4 , 0 , "Done") { 
      app_stack.pop
    }
  end

  def update
    @new.update
    @profile.update
    @done.update
    @garage.update
    @shop.update
  end

  def draw
    @x = @win.mouse_x
    @y = @win.mouse_y
    @bg.draw(0 , 0 , 0 , @factorX , @factorY)
    @pen.draw( @x , @y - @pen.height , 5, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
    @new.draw
    @profile.draw
    @done.draw
    @garage.draw
    @shop.draw
  end
end
