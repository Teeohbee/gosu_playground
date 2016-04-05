require 'gosu'
require_relative 'lib/star.rb'
require_relative 'lib/player.rb'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"
    @background_image = Gosu::Image.new("media/space.png", tileable: true)
    @player = Player.new
    @player.warp(320, 240)
    @star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
    @stars = Array.new
    @font = Gosu::Font.new(20)
  end

  def update
    @player.turn_left if Gosu::button_down? Gosu::KbLeft
    @player.turn_right if Gosu::button_down? Gosu::KbRight
    @player.accelerate if Gosu::button_down? Gosu::KbUp
    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Star.new(@star_anim))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

module ZOrder
  Background, Stars, Player, UI = *0..3
end

window = GameWindow.new
window.show
