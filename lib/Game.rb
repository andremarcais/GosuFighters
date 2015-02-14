require 'player'
require 'hp'
require 'ball'
require 'Resource_Ship'
require 'Power_Up'
require 'flame'
require 'Explosion'
require 'Missil'
require 'Accessory'
require 'Powerup_EX'
require 'Tag'

Z_BAR = 1
Z_PLAYER = 2

class GameControl
  def initialize(window , next_app)
    @win = window
    @next_app = next_app
    @miss_icon = Gosu::Image.new(@win, "media/imgs/Missil_Icon.png" , false)
    
    @bg = Gosu::Image.new(@win, "media/imgs/Horse Head Nebula.jpg", true)
    @scale_x = $width.to_f/@bg.width
    @scale_y = $height.to_f/@bg.height

    @death_timer = 0

    @p1_hp = HpBar.new(@win, "media/imgs/Hpp1.png", 14 , 14, false)
    @p1_amo = HpBar.new(@win, "media/imgs/Amo_Bar.png", 14 , 14+@p1_hp.height, false, true)
    @p1_shield = HpBar.new(@win, "media/imgs/Shield_bar.png", 14 , (@p1_hp.height/2)+14+@p1_hp.height, false)
    
    @p1 = Player.new(@win, "media/imgs/Starfighter1.png", @p1_hp, @p1_amo , @p1_shield , Tag.new( @miss_icon , 0 , 14 , @p1_hp.height + @p1_amo.height + @p1_shield.height + 4 , Gosu::Font.new(@win , Gosu::default_font_name , 25)))
    @p1.warp($width / 3, $height / 2)
    @p1_left = @win.char_to_button_id("a")
    @p1_right = @win.char_to_button_id("d")
    @p1_accel =  @win.char_to_button_id("w")
    @p1_fire = @win.char_to_button_id(" ")
    @p1_missil = Gosu::KbLeftShift

    @p2_hp = HpBar.new(@win, "media/imgs/Hpp2.png", $width - 14, 14, true)
    @p2_amo = HpBar.new(@win, "media/imgs/Amo_Bar.png", $width - 14 , 14+@p1_hp.height , true , true)
    @p2_shield = HpBar.new(@win, "media/imgs/Shield_bar.png", $width - 14 , (@p1_hp.height/2)+14+@p1_hp.height, true)

    @p2 = Player.new(@win, "media/imgs/Starfighter2.png", @p2_hp, @p2_amo, @p2_shield , Tag.new( @miss_icon , 0 , ($width - 14) - @miss_icon.width , @p2_hp.height + @p2_amo.height + @p2_shield.height + 4 , Gosu::Font.new(@win , Gosu::default_font_name , 25)))
    @p2.warp(2 * $width / 3, $height / 2)
    @p2_left = Gosu::KbLeft
    @p2_right = Gosu::KbRight
    @p2_accel = Gosu::KbUp
    @p2_fire = Gosu::KbRightControl
    @p2_missil = Gosu::KbRightAlt

    Player.set_img(Gosu::Image.new(@win, "media/imgs/magic ball.png", false),
                   Gosu::Image.new(@win, "media/imgs/Starfighter Structure.png" , false),
                   Gosu::Sample.new(@win, "media/sounds/Fire_Sound.ogg"),
                   Gosu::Sample.new(@win, "media/sounds/Explosion.ogg"),
                   [
                    Gosu::Sample.new(@win, "media/sounds/engine_fail.ogg"),
                    Gosu::Sample.new(@win, "media/sounds/eg2.ogg"),
                    Gosu::Sample.new(@win, "media/sounds/eg3.ogg"),
                   ], 
                   Gosu::Image.new(@win, "media/imgs/Missil_Icon.png" , false),
                   Gosu::Font.new(@win , Gosu::default_font_name , 25)
                   )

    Ball.set_img(Gosu::Image.new(@win, "media/imgs/magic ball.png", false),
                 Gosu::Image.new(@win, "media/imgs/lightning ball.png", false),
                 Gosu::Sample.new(@win, "media/sounds/Fire_Sound.ogg"),
                 Gosu::Sample.new(@win, "media/sounds/Explosion.ogg"))

    R_Ship.set_img(Gosu::Image.new(@win , "media/imgs/Resource Ship.png" , false))

    Power_up.set_img(@win)
    
    Flame.set_img(@win)

    Missil.set_img(@win ,  Gosu::Sample.new(@win, "media/sounds/Explosion.ogg"))

    Explode.set_data(@win, Gosu::Sample.new(@win, "media/sounds/Explosion.ogg"))
    
    Accessory.set_data(@win)

    Powerup_EX.set_data(@win)
    
    @balls = []
    @power_ups = []
    @flames = []
    @boom = []
    @missils = []
    @stuff = []
    
    @time = Gosu::milliseconds
    @play = true
  end

  def update
    @time = Gosu::milliseconds
    
    @balls.reject!{|b| @p1.hit(b, @boom , @stuff) || @p2.hit(b, @boom , @stuff) || @missils.any?{|m| m.hit(b, @boom) } || b.move(@time) }
    @power_ups.reject!{|b| @p1.catch(b) || @p2.catch(b) }
    @missils.reject!{|m|
      if @p1.hit(m , nil , @stuff) || @p2.hit(m , nil , @stuff) || m.hp <= 0
        explosion = Explode.new(m.x + Gosu::offset_x(m.angle, m.height / 2),
                                m.y + Gosu::offset_y(m.angle, m.height / 2),
                                4 , 2.75 , 20)
        @boom << explosion
        @p1.hit(explosion, @boom , @stuff)
        @p2.hit(explosion, @boom , @stuff)
        true
      else
        m.move(@flames)
        false
      end
    }

    @stuff.each{|s| s.move(@flames)}
    @boom.reject!{|b| b.update}

    @p1.turn_left if @win.button_down? @p1_left
    @p1.turn_right if @win.button_down? @p1_right
    @p1.accelerate(@flames) if @win.button_down? @p1_accel
    @p1.fire(@balls, @time) if @win.button_down? @p1_fire
    @p1.fire_missil(@missils , @p2 , @time) if @win.button_down? @p1_missil
    @p1.move

    @p2.turn_left if @win.button_down? @p2_left
    @p2.turn_right if @win.button_down?  @p2_right
    @p2.accelerate(@flames) if @win.button_down? @p2_accel
    @p2.fire(@balls, @time) if @win.button_down? @p2_fire
    @p2.fire_missil(@missils , @p1 , @time) if @win.button_down? @p2_missil
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
      @r_ship = R_Ship.new if rand(2000) == 0 || @p1.amo.percent <= 0 || @p2.amo.percent <= 0
    else
      if !@r_ship.move
        @r_ship = nil
      elsif rand(200) == 0
        @power_ups << @r_ship.r_drop
      end
    end
    @power_ups.each{ |pu| pu.move(@p1 , @p2) }
    @flames.reject!{|f| f.update }
    @death_timer += 1 if @p1.dead || @p2.dead
    return @next_app.new(@win , self.class) if @death_timer > 360
    self
  end

  def draw
    @bg.draw(0, 0, 0 , @scale_x , @scale_y)
    @p1.draw(@flames)                  
    @p2.draw(@flames)
    @p1_hp.draw
    @p2_hp.draw
    @p1_amo.draw
    @p2_amo.draw
    @balls.each{|b| b.draw(@time) }
    @r_ship.draw if !@r_ship.nil?
    @power_ups.each{ |pu| pu.draw }
    @p1_shield.draw
    @p2_shield.draw
    @boom.each{|b| b.draw}
    @flames.each{|f| f.draw}
    @missils.each{|m| m.draw}
    @stuff.each {|s| s.draw }
  end
end
