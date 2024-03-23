class NewProfile

  def initialize(win , app_stack)
    @win = win
    @y1 = $height/2
    @y2 = $height/2 + 100
    @bg = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", false)
    @factorX = $width.to_f / @bg.width 
    @factorY = $height.to_f / @bg.height
    @pen = Gosu::Image.new(@win, "media/imgs/lazer pen.png", false)
    @text1 = Gosu::Image.from_text(@win , "Screen Name:" , @@font.name , 25)
    @tbox1 = TextField.new(@win , $width/2 , @y1 , 200 , "Screen Name")
    @text2 = Gosu::Image.from_text(@win , "Image Path:" , @@font.name , 25)
    @tbox2 = TextField.new(@win , $width/2 , @y2 , 200 , "Image Path")
    # @text3 = Gosu::Image.from_text(@win , "Super Power:" , @@font.name , 25)
    # @n_EX = Button.new(@win , $width/3 + 75, @y1 , 0.5 , 0 , "--->" , "media/imgs/Arrow_button_br.png") { 
    #   @ex_num += 1
    # }
    # @p_EX = Button.new(@win , $width/3 - 75, @y1 , 0.5 , 0 , "<---" , "media/imgs/Arrow_button_bl.png") { 
    #   @ex_num -= 1
    # }
    # @ex = Gosu::Image.from_text(@win , "#{@ex_ary[@ex_num]}" , @@font.name , 25)
    @next_app = self
    @done = Button.new(@win , $width/2, $height - 100 , 4 , 0 , "Done") {
      n = @tbox1.text
      @player_data = {:ship => 0 , :coins => 50, :name => n , :inventory => {:ex => [nil] , :gun => [{:amo => 100 , :damage => 1 , :acuracy => 0 , :speed => 100 }]} , :ships => [{ :ex => 0 , :hp => 100 , :sheild => 100 , :gun => 0 , :ship => 0 }]}
      
      
      if n != ""
        open(File.expand_path("~/.gosu_fighters/Player_data/#{n}"), "w") { |f|
          f.puts "#{@player_data.to_json}"
        }
      end
      
      app_stack.pop
    }
  end

  def update
    @tbox1.update
    @tbox2.update
    @done.update
    # @p_EX.update
    # @n_EX.update
    # @ex = Gosu::Image.from_text(@win , "#{@ex_ary[@ex_num]}" , @@font.name , 25)
  end

  def draw
    @bg.draw(0 ,0 , 0 , @factorX , @factorY)
    @pen.draw(@win.mouse_x , @win.mouse_y - @pen.height , 5, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
    @text1.draw($width/2, @y2 - 130 , 1)
    @tbox1.draw
    @text2.draw($width/2 , @y2 - 30, 1)
    @tbox2.draw
    # @text3.draw($width/3 - 25 , @y1 - 45 , 1)
    @done.draw
    # @p_EX.draw
    # @n_EX.draw
    # @ex.draw($width/3 - 25 , @y1 , 1)
  end
  
  def self.set_data(win)
    @@font = Gosu::Font.new(win , Gosu::default_font_name , 25)
  end
end
