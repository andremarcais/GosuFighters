#! /usr/bin/env ruby

$: << "./lib/Controls" << "./lib/Elements"

require 'gosu'
require 'Game'
require 'Title_screen'
require 'New Profile'
require 'Button'
require 'Text Input'
require 'register'

$width = Gosu::screen_width
$height = Gosu::screen_height



class GameWindow < Gosu::Window
  def initialize
    super($width, $height, true)
    self.caption = "Gosu Fighters"

    @app = TitleControl.new(self, GameControl)
  end

  def update
    @app = @app.update
  end
  
  def draw
    @app.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
