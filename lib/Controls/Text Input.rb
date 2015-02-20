class TextField
  attr_reader :text
  def initialize(win, x, y, width , text = "")
    @win, @x, @y = win, x, y
    @bg = Gosu::Image.new(@win, "media/imgs/Text_box.png", false)
    @font = Gosu::Font.new(@win,  Gosu::default_font_name , (0.8 * @bg.height).ceil)
    @scale_x = width.to_f / @bg.width.to_f
    @text_input = Gosu::TextInput.new
    @text = text
    @has_focus = false
    update
  end

  def update
    mx, my = @win.mouse_x, @win.mouse_y
    click = @win.button_down?(Gosu::MsLeft)

    if click
      in_bg = mx >= @x && mx < @x + @bg.width * @scale_x && my >= @y && my < @y + @bg.height
      if in_bg && !@has_focus
        @has_focus = true
        @win.text_input = @text_input
      elsif !in_bg
        @has_focus = false
        @win.text_input = nil if @win.text_input == @text_input
      end
    end

    @text = @text_input.text
    @color = @has_focus ? Gosu::Color::WHITE : Gosu::Color::GRAY
  end

  def draw
    @bg.draw(@x, @y, 1, @scale_x, 1, @color)
    @font.draw(@text , @x + 0.1 * @bg.height , @y + 0.1 * @bg.height, 1)
  end
end
