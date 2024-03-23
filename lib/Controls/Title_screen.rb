require 'Text Input'

class TitleControl

  def initialize(window, app_stack)
    @win = window
    Button.set_data(@win)
    NewProfile.set_data(@win)
    @bg = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", true)
    @pen = Gosu::Image.new(@win, "media/imgs/lazer pen.png", false)
    @click = Gosu::MsLeft
    @t_p1profile = Gosu::Image.from_text(@win , "Profile:#{@p1profile}" , @@font.name , 25)
    @t_p2profile = Gosu::Image.from_text(@win , "Profile:#{@p2profile}" , @@font.name , 25)
    @factorX = $width.to_f / @bg.width 
    @factorY = $height.to_f / @bg.height
    @next_app = self
    @play = Button.new(@win , $width/2, $height - 100 , 4 , 0 , "Start") { 
      app_stack << GameControl.new(@win , app_stack , @npc)
    }
    @P1 = Button.new(@win , $width * 1/4 , $height/3, 2 , 0 , "P1") { 
      app_stack << PlayerPage.new(@win , app_stack , 1)
    }
    @P2 = Button.new(@win , $width * 2/4 , $height/3 , 2 , 0 , "P2") { 
      app_stack << PlayerPage.new(@win , app_stack , 2)
    }
    @options = Button.new(@win , $width/2 - 150, $height/2 , 1 , 0 , "Options") {
            app_stack << Options.new(@win , app_stack , @@font)
    }
    # @p1_profile = Button.new(@win , $width/2 - 20 , $height/2 - 125 , 1 , 0 , "Register") {
    #   app_stack << Register.new(@win , app_stack , 1)
    # }
    # @p2_profile = Button.new(@win , $width/2 - 300 , $height/2 - 125 , 1 , 0 , "Register") {
    #   app_stack << Register.new(@win , app_stack , 2)
    # }
    # @new = Button.new(@win , $width/2 - 50, $height/2 + 100, 1 , 0 , "Create New Profile") {
    #   app_stack << NewProfile.new(@win , app_stack)
    # }
    # @npc_button = Button.new(@win , $width/2 - 150, $height/2 - 50 , 1 , 0 , "NPC: #{@npc}") {
    #   @npc = !@npc
    # }
    # @Three_Dimension = Button.new(@win , $width/2 - 150, $height/2 - 70 , 1 , 0 , "3D: #{@npc}") {
    #   $three_dimension = !$three_dimension
    # }
  end

  def update
    @play.update
    @P1.update
    @P2.update
    @options.update
    # @new.update
    # @p1_profile.update
    # @p2_profile.update
    # @npc_button.update("NPC: #{@npc}")
    # @Three_Dimension.update("3D: #{$three_dimension}")
      @t_p1profile = Gosu::Image.from_text(@win , "Profile:#{$profile_1}" , @@font.name , 25)
      @t_p2profile = Gosu::Image.from_text(@win , "Profile:#{$profile_2}" , @@font.name , 25)
    # @x = @win.mouse_x
    # @y = @win.mouse_y
    # @pen_over = @x < $width / 2 + 54.5 && @x > $width / 2 - 54.5 && @y > $height - 100
    # if @pen_over && @win.button_down?(Gosu::MsLeft)
    #   return @next_app.new(@win, self.class)
    # end
    if @npc == true
      $profile_2 = nil
    end
  end

  def draw
    @x = @win.mouse_x
    @y = @win.mouse_y
    @bg.draw(0 , 0 , 0 , @factorX , @factorY)
    @pen.draw( @x , @y - @pen.height , 5, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
    @t_p1profile.draw($width * 1/4 , $height/3 + 20 , 1)
    @t_p2profile.draw($width * 2/4 , $height/3 + 20 , 1)
    @play.draw
    @options.draw
    @P1.draw
    @P2.draw
    # @new.draw
    # @p1_profile.draw
    # @p2_profile.draw
    # @npc_button.draw
    # @Three_Dimension.draw
  end

  def self.set_data(win)
    @@font = Gosu::Font.new(win , Gosu::default_font_name , 25)
  end
end
