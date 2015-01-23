#! /usr/bin/env ruby

$: << "."

require 'gosu'
require 'player'
require 'hp'
require 'ball'
require 'Resource_Ship'
require 'Power_Up'

$width = Gosu::screen_width
$height = Gosu::screen_height

Z_BAR = 1
Z_PLAYER = 2

class GameWindow < Gosu::Window
  def initialize
    super($width, $height, true)
    self.caption = "Future Coliseum"

    @bg = Gosu::Image.new(self, "Horse Head Nebula.jpg", true)
    @scale_x = $width.to_f/@bg.width
    @scale_y = $height.to_f/@bg.height

    @p1_hp = HpBar.new(self, "Hpp1.png", 14 , 14, false)
    @p1_amo = HpBar.new(self, "Amo_Bar.png", 14 , 14+@p1_hp.height, false)
    @p1_sheiled = HpBar.new(self, "Sheiled_bar.png", 14 , (@p1_hp.height/2)+14+@p1_hp.height, false)
    
    @p1 = Player.new(self, "Starfighter1.png", @p1_hp, @p1_amo , @p1_sheiled)
    @p1.warp($width / 3, $height / 2)
    @p1_left = char_to_button_id("a")
    @p1_right = char_to_button_id("d")
    @p1_accel =  char_to_button_id("w")
    @p1_fire = char_to_button_id(" ")

    @p2_hp = HpBar.new(self, "Hpp2.png", self.width - 14, 14, true)
    @p2_amo = HpBar.new(self, "Amo_Bar.png", self.width - 14 , 14+@p1_hp.height , true)
    @p2_sheiled = HpBar.new(self, "Sheiled_bar.png", 14 , (@p1_hp.height/2)+14+@p1_hp.height, false)

    @p2 = Player.new(self, "Starfighter2.png", @p2_hp, @p2_amo, @p2_sheiled)
    @p2.warp(2 * $width / 3, $height / 2)
    @p2_left = Gosu::KbLeft
    @p2_right = Gosu::KbRight
    @p2_accel = Gosu::KbUp
    @p2_fire = Gosu::KbRightControl

    Player.set_img(Gosu::Image.new(self, "magic ball.png", false),
                 Gosu::Image.new(self, "lightning ball.png", false),
                 Gosu::Sample.new(self, "Fire_Sound.ogg"),
                 Gosu::Sample.new(self, "Explosion.ogg"))

    Ball.set_img(Gosu::Image.new(self, "magic ball.png", false),
                 Gosu::Image.new(self, "lightning ball.png", false),
                 Gosu::Sample.new(self, "Fire_Sound.ogg"),
                 Gosu::Sample.new(self, "Explosion.ogg"))

    R_Ship.set_img(Gosu::Image.new(self , "Resource Ship.png" , false))

    Power_up.set_img(self)


    @balls = []
    @power_ups = []

    @time = Gosu::milliseconds
  end

  def update
    @time = Gosu::milliseconds
    @balls.reject!{|b| @p1.hit(b) || @p2.hit(b) || b.move(@time) }
    @power_ups.reject!{|b| @p1.catch(b) || @p2.catch(b) }

    @p1.turn_left if button_down? @p1_left
    @p1.turn_right if button_down? @p1_right
    @p1.accelerate if button_down? @p1_accel
    @p1.fire(@balls, @time) if button_down? @p1_fire
    @p1.move

    @p2.turn_left if button_down? @p2_left
    @p2.turn_right if button_down?  @p2_right
    @p2.accelerate if button_down? @p2_accel
    @p2.fire(@balls, @time) if button_down? @p2_fire
    @p2.move

    @power_ups.each { |p|
      if @p1.catch(p) == true
        p "player one caught hp" if p.type == 1
        p "player one caught sheiled" if p.type == 2
        p "player one caught missil" if p.type == 3 
        @p1.+_amo if p.type == 4  
      elsif @p2.catch(p) == true
        @p1.+_amo if p.type == 4  
      end
    }
    if @r_ship.nil?
      @r_ship = R_Ship.new if rand(2000) == 0
    else
      if !@r_ship.move
        @r_ship = nil
      elsif rand(200) == 0
        @power_ups << @r_ship.r_drop
      end
    end
    @power_ups.each{ |pu| pu.move }
  end
  
  def draw
    @p1.draw
    @p2.draw
    @p1_hp.draw
    @p2_hp.draw
    @p1_amo.draw
    @p2_amo.draw
    @balls.each{|b| b.draw(@time) }
    @bg.draw(0, 0, 0, @scale_x, @scale_y)
    @r_ship.draw if !@r_ship.nil?
    @power_ups.each{ |pu| pu.draw }
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
