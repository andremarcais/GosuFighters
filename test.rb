#! /usr/bin/env ruby

require 'gosu'

$width = Gosu::screen_width
$height = Gosu::screen_height

class Player
  def initialize(window, path)
    @image = Gosu::Image.new(window, path, false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= $width
    @y %= $height

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end

class HpBar
  def initialize(window, path, x , y)
    @x, @y = x, y
    @percent = 100.0
    @image = Gosu::Image.new(window, path, false)
  end

  def draw
    @image.draw(@x, @y, 1, @percent/100, 1)
  end
end

class GameWindow < Gosu::Window
  def initialize
    super($width, $height, true)
    self.caption = "Shadow Night Light Version"

    @bg = Gosu::Image.new(self, "Horse Head Nebula.jpg", true)
    @scale_x = $width.to_f/@bg.width
    @scale_y = $height.to_f/@bg.height

    @p1 = Player.new(self, "Starfighter1.png")
    @p1.warp($width / 2, $height / 2)
    @p1_hp = HpBar.new(self, "Hpp1.png", 7 , 7)

    @p2 = Player.new(self, "Starfighter2.png")
    @p2.warp($width / 2, $height / 2)
    @p2_left = char_to_button_id("a")
    @p2_right = char_to_button_id("d")
    @p2_accel =  char_to_button_id("w")
    @p2_hp = HpBar.new(self, "Hpp2.png", self.width-107 , 7)
  end

  def update
    @p1.turn_left if button_down? Gosu::KbLeft
    @p1.turn_right if button_down? Gosu::KbRight
    @p1.accelerate if button_down? Gosu::KbUp
    @p1.move

    @p2.turn_left if button_down? @p2_left
    @p2.turn_right if button_down?  @p2_right
    @p2.accelerate if button_down? @p2_accel
    @p2.move
  end

  def draw
    @p1.draw
    @p2.draw
    @p1_hp.draw
    @p2_hp.draw
    @bg.draw(0, 0, 0, @scale_x, @scale_y)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
