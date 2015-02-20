class NewProfile

  def initialize(win)
    @win = win
    @y1 = $height/2
    @y2 = $height/2 + 100
    @bg = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", false)
    @factorX = $width.to_f / @bg.width 
    @factorY = $height.to_f / @bg.height
    @pen = Gosu::Image.new(@win, "media/imgs/lazer pen.png", false)
    @text1 = Gosu::Image.from_text(@win , "Screen Name:" , @@font , 25)
    @tbox1 = TextField.new(@win , $width/2 , @y1 , 200 , "Screen Name")
    @text2 = Gosu::Image.from_text(@win , "Image Path:" , @@font , 25)
    @tbox2 = TextField.new(@win , $width/2 , @y2 , 200 , "Image Path")
    @next_app = self
    @done = Button.new(@win , $width/2, $height - 100 , 4 , 0 , "Done") {
      n = @tbox1.text

      open(File.expand_path("~/.gosu_fighters/Player_data/#{n}"), "w") { |f|
        f.puts "Screen name:#{n}"
        f.puts "Image Path:#{@tbox2.text}"
      }
      
      @next_app = TitleControl.new(@win, GameControl)
    }
  end

  def update
    @tbox1.update
    @tbox2.update
    @done.update
    return @next_app
  end

  def draw
    @bg.draw(0 ,0 , 0 , @factorX , @factorY)
    @pen.draw(@win.mouse_x , @win.mouse_y - @pen.height , 5, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
    @text1.draw(@y1 - 30 , $width/2 , 1)
    @tbox1.draw
    @text2.draw(@y2 - 30 , $width/2 , 1)
    @tbox2.draw
    @done.draw
  end
  
  def self.set_data(win)
    @@font = Gosu::Font.new(win , Gosu::default_font_name , 25)
  end
end
