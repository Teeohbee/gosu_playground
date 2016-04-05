require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"

    @background_image = Gosu::Image.new("space.png", tileable: true)

    @player = Player.new
    @player.warp(320, 240)
  end

  def update
    if Gosu::button_down? Gosu::KbLeft then
      @player.turn_left
    end
    if Gosu::button_down? Gosu::KbRight then
      @player.turn_right
    end
    if Gosu::button_down? Gosu::KbUp  then
      @player.accelerate
    end
    @player.move
  end

  def draw
    @background_image.draw(0, 0, 0)
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

class Player
  def initialize
    @image = Gosu::Image.new("starfighter.bmp")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x = x
    @y = y
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
    @x %=  640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end

window = GameWindow.new
window.show
