require 'player_status'

class Register
  def initialize( win , app_stack , player)
    @win = win
    @bg1 = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", true)
    @bg2 = Gosu::Image.new(@win, "media/imgs/Title Sceen_p.png", true)
    @button_y = $height - ($height - 200)
    @player = player
    @next_app = self
    @pen = Gosu::Image.new(@win, "media/imgs/lazer pen.png", false)
    @factorX = $width.to_f / @bg1.width 
    @factorY = $height.to_f / @bg1.height
    y = (@bg2.height * @factorY)/5
    @profiles = Dir.foreach(File.expand_path("~/.gosu_fighters/Player_data")).map {|p| 
      next if p[0] == "."
      y += 60
      Button.new(@win ,  (@bg2.width * @factorX)/3 , y - 30 , 2 , 0 , "#{p}"){
        if @player == 1
          $profile_1 = p
          $p1_data = Status.open_from_name(p)
          p $p1_data
        else
          $profile_2 = p
          $p2_data = Status.open_from_name(p)
          p $p2_data
        end
      }
    }.compact

    @done = Button.new(@win , $width * 2/3 , $height - 100 , 4 , 0 , "Done") {
#      @next_app = TitleControl.new(@win, GameControl , @profile) if @player == 1
#      @next_app = TitleControl.new(@win, GameControl , nil , @profile) if @player == 2
      
      app_stack.pop
    }
  end  
  
  def valid(tag)
    
  end

  def update
    @done.update
    @profiles.each{|p|
      p.update
    }
  end
  
  def draw
    @x = @win.mouse_x
    @y = @win.mouse_y
    @bg1.draw( 0 ,0 , 0 , @factorX , @factorY)
    @bg2.draw( 0 ,0 , 2 , @factorX , @factorY)
    @profiles.each {|p|
      p.draw
    }
    @done.draw
    @pen.draw( @x , @y - @pen.height , 5, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
  end
end
