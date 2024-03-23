class Shop

  def initialize(window, app_stack , p)
    @p = p
    @win = window
    @bg = Gosu::Image.new(@win, "media/imgs/Shop.png", true)
    @factorX = $width.to_f / @bg.width 
    @factorY = $height.to_f / @bg.height
    @pen = Gosu::Image.new(@win, "media/imgs/hammer.png", false)
    @click = Gosu::MsLeft
    @y1 = $height/2
    if @p == 1
      d = $p1_data
      c = $p1_data["coins"] if d != nil
    elsif @p == 2
      d = $p2_data
      c = $p2_data["coins"] if d != nil     
    end 
    if d != nil
      @money_icon = Gosu::Image.new(@win, "media/imgs/Money_Icon.png" , false)
      @coins = Tag.new( @money_icon , c , 28 , 28 , Gosu::Font.new(@win , Gosu::default_font_name , 40)) 
    end
    @ex_num = 0
    @ex_ary = ["Oh Fudge" , "Lazer" , "Nuke" , ">:) ME 
HYPER!!!" , "Assistance" , "Super 
Ram" , "Flame 
Thrower"]
    @text3 = Gosu::Image.from_text(@win , "Super Power:" , @@font.name , 25)
    @n_EX = Button.new(@win , $width/3 + 75, @y1 , 0.5 , 0 , "--->" , "media/imgs/Arrow_button_br.png") { 
      @ex_num += 1
    }
    @p_EX = Button.new(@win , $width/3 - 75, @y1 , 0.5 , 0 , "<---" , "media/imgs/Arrow_button_bl.png") { 
      @ex_num -= 1
    }
    @ex = Gosu::Image.from_text(@win , "#{@ex_ary[@ex_num]}" , @@font.name , 25)
    @done = Button.new(@win , $width/2, $height - 100 , 4 , 0 , "Done") { 
      app_stack.pop
    }
  end

  def update
    @n_EX.update
    @p_EX.update
    @done.update
  end

  def draw
    @x = @win.mouse_x
    @y = @win.mouse_y
    @bg.draw(0 , 0 , 0 , @factorX , @factorY)
    @pen.draw( @x , @y - @pen.height , 5, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
    @coins.draw(3) if @coins != nil
    @text3.draw($width/3 - 25 , @y1 - 45 , 1)
    @p_EX.draw
    @n_EX.draw
    @ex.draw($width/3 - 25 , @y1 , 1)
    @done.draw
  end

  def self.set_data(win)
    @@font = Gosu::Font.new(win , Gosu::default_font_name , 25)
  end
end
