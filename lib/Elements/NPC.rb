class NPC
  attr_reader :left , :right , :accel , :fire , :missil

  def initialize( m , t )
    @me = m
    @target = t
    @ofense = 0
    @left = false
    @right = false
    @accel = true
    @fire = true
    @missil = false
    @mbd = 0
  end

  def update(balls , pw)
    # balls.each{ |b|
    #   if Gosu::angel_diff(@me.x+rand(0.0..1.0) , @me.y+rand(0.0..1.0) , b.x , b.y) > 0
    
    #     else
    
    #   end
    # }
    @ofense = @me.hp.percent
    target_angle = Gosu::angle(@me.x+rand(-5.0..5.0) , @me.y+rand(-5.0..5.0) , @target.x+rand(-5.0..5.0) , @target.y+rand(-5.0..5.0))+rand(-5.0..5.0)
    angle_diff = Gosu::angle_diff(@me.angle , target_angle)+rand(-5.0..5.0)
    if pw[0] != nil
      target_angle2 = Gosu::angle(@me.x+rand(0.0..1.0) , @me.y+rand(0.0..1.0) , pw[0].x+rand(0.0..1.0) , pw[0].y+rand(0.0..1.0))
      angle_diff2 = Gosu::angle_diff(@me.angle , target_angle2)+rand(0.0..3.0)
    end
    
    if @ofense > rand(35..65)
      if @me.amo.percent == 0
        if angle_diff2 != nil
          if angle_diff2 > 0
            @right = true
            @left = false
          elsif angle_diff2 < 0
            @right = false
            @left = true
          else
            
          end
        end
      else
        if angle_diff > 0
          @right = true
          @left = false
        else
          @right = false
          @left = true
        end
      end
      @fire = angle_diff.abs < 15
      @missil = Gosu::distance(@me.x, @me.y , @target.x , @target.y) > 50
    else
      @fire = angle_diff.abs < 15
      @missil = Gosu::distance(@me.x, @me.y , @target.x , @target.y) > 50
      if angle_diff2 != nil
        if angle_diff2 > 0
          @right = true
          @left = false
        elsif angle_diff2 < 0
          @right = false
          @left = true
        else
          
        end
      else
        balls.each{ |b|
          target_angle3 = Gosu::angle(@me.x+rand(0.0..1.0) , @me.y+rand(0.0..1.0) , b.x+rand(0.0..1.0) , b.y+rand(0.0..1.0))
          angle_diff3 = Gosu::angle_diff(@me.angle , target_angle3)+rand(0.0..3.0)
          if Gosu::distance(@me.x, @me.y , b.x , b.y)
            if angle_diff3 < 0
              @right = true
              @left = false
            elsif angle_diff3 > 0
              @right = false
              @left = true
            end
          end
        }
      end
    end
  end
end
