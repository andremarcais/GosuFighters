require 'Text Input'

class Options
  
  def initialize(window, app_stack , font)
    @font = font
    @win = window
    Button.set_data(@win)
    NewProfile.set_data(@win)
    @bg = Gosu::Image.new(@win, "media/imgs/Title Sceen.png", true)
    @pen = Gosu::Image.new(@win, "media/imgs/lazer pen.png", false)
    @click = Gosu::MsLeft
    @t_p1profile = Gosu::Image.from_text(@win , "Profile:#{@p1profile}" , @font.name , 25)
    @t_p2profile = Gosu::Image.from_text(@win , "Profile:#{@p2profile}" , @font.name , 25)
    @factorX = $width.to_f / @bg.width 
    @factorY = $height.to_f / @bg.height
    @next_app = self
    @done = Button.new(@win , $width/2, $height - 100 , 4 , 0 , "Done") { 
      app_stack.pop
    }
    # @p1_profile = Button.new(@win , $width/2 - 20 , $height/2 - 125 , 1 , 0 , "Register") {
    #   app_stack << Register.new(@win , app_stack , 1)
    # }
    # @p2_profile = Button.new(@win , $width/2 - 300 , $height/2 - 125 , 1 , 0 , "Register") {
    #   app_stack << Register.new(@win , app_stack , 2)
    # }
    # @new = Button.new(@win , $width/2 - 50, $height/2 + 100, 1 , 0 , "Create New Profile") {
      # app_stack << NewProfile.new(@win , app_stack)
    # }
    @npc_button = Button.new(@win , $width/2 - 150, $height/2 - 50 , 1 , 0 , "NPC: #{$npc}") {
      $npc = !$npc
      $profile_2 = nil
    }
    @Three_Dimension = Button.new(@win , $width/2 - 150, $height/2 - 70 , 1 , 0 , "3D: #{$tree_dimesion}") {
      $three_dimension = !$three_dimension
    }  
    @x = @win.mouse_x
    @y = @win.mouse_y
  end

  def update
    @x = @win.mouse_x
    @y = @win.mouse_y
    # @new.update
    # @p1_profile.update
    # @p2_profile.update
    @npc_button.update("NPC: #{$npc}")
    @Three_Dimension.update("3D: #{$three_dimension}")
    @done.update
  end

  def draw
    @bg.draw(0 , 0 , 0 , @factorX , @factorY)
    @pen.draw( @x , @y - @pen.height , 5, 1, 1,
               @pen_over ? Gosu::Color::GRAY : Gosu::Color::WHITE)
    # @new.draw
    # @p1_profile.draw
    # @p2_profile.draw
    @npc_button.draw
    @Three_Dimension.draw
    @done.draw
  end
end
