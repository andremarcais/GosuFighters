#! /usr/bin/env ruby

$: << "./lib/Controls" << "./lib/Elements"

require 'gosu'
require 'json'
require 'Shop'
require 'Game'
require 'Garage'
require 'Title_screen'
require 'New Profile'
require 'Button'
require 'Text Input'
require 'register'
require 'Options'
require 'PlayerPage'

$width = Gosu::screen_width
$height = Gosu::screen_height

$profile_1 = nil
$profile_2 = nil
$p1_data = nil
$p2_data = nil

$fight_type = 0

$three_dimension = false
$npc = false

class GameWindow < Gosu::Window
  def initialize
    super($width, $height, true)
    self.caption = "Gosu Fighters"
    @app_stack = []
    TitleControl.set_data(self)
    Shop.set_data(self)
    Garage.set_data(self)
    @app_stack << TitleControl.new(self, @app_stack)
  end

  def update
    close if @app_stack.empty?
    @app_stack[-1].update
  end
  
  def draw
    @app_stack[-1].draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
