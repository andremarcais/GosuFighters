class P1Register
  
  def initialize
    @bg1 = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", true)
    @bg2 = Gosu::Image.new(@win, "media/imgs/Title Sceen_p.png", true)
    @button_y = $height - ($height - 200)
    @profiles = Dir.foreach("~/.gosu_fighters/Player_data") {|p| 
      next if p[0] == "."
      Button.new
    }
  end  
  
  def update
    
  end
  
  def draw
    
  end
end
