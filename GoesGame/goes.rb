##this is my first ruby game!
## Gosu only supports two image types, BMP and PNG so keep that in mind!
##
=begin
The original maker's github comments will be included to help make sense of what
happens in the code. I am not a ruby expert yet so some of this is guesswork on
my part.

Key points
	-ZOrder module
	-Color
	-image
	-draw
	-draw_rot
	-draw_quad
=end
require 'gosu'

## Use module to define relative Z-order of game elements

module ZOrder
	Background = 0
	Star = 1
	Shot = 2
	Ship = 3
	UI = 4
end

class GameWindow < Gosu::Window

  def initialize
   super(640, 480, false)
   self.caption = "Go Graphics Go"

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	# unknown function for the counter here
    @counter = 0
	
  ##Load image assets
  ##Params: window, file path, tileable?	

    @background_image = Gosu::Image.new(self,"BGStars.BMP", true)

  ## Given a 'sprite' image, splits it into evenly-sized 'tiles'
  ## based on given width, height
  ## returns an array of Gosu::Image objects
    @star_anim = Gosu::Image::load_tiles(self, "starfile.PNG", 25, 25, false)

  ## Keep in mind that pure magenta color (0xffff00ff) in BMP files
  ## is rendered as transparent
    @ship_image = Gosu::Image.new(self, "Ship1.PNG ", false)

  ## Original tutorial includes an element here used later
  ## decided not to include it because fuck all that fancy 
  ## 'shield' shit anyway.
  ## 
  ## @shield_image = Gosu::Image.new(self, "media/shield.png", false)

 end #end of def initialize


  def update
       @counter += 1
  end

 	 ## Updated this command with new params including ZOrder
 	 ## and color specifications
  def draw
    @font.draw("Updates: #{@counter}", 0, 0, ZOrder::UI, 1.0, 1.0, 0xffffff00)

  ## params: x,y,z
    @background_image.draw(0, 0, ZOrder::Background)

  ## display each image tile separately
    @star_anim.each_with_index do |tile, i|
	  tile.draw(100 + (40 * i), 50, ZOrder::Star)
  	  end
  ## Iterate through tiles by selecting appropriate image from array
    img = @star_anim[(Gosu::milliseconds / 100) % @star_anim.size]
    img.draw(100, 120, ZOrder::Star)

 ## Scaled up 2X with color shift
    img.draw(100, 220, ZOrder::Star, 2.0, 2.0, 0xff1199dd)

 ## rotated -90 degrees, scaled up 3x with color shift
 ## note that image is drawn centered at x,y instead of top,left
    img.draw_rot(100, 340, ZOrder::Star, -90, 0.5, 0.5, 3.0, 3.0, 0xff99dd33)

 ## use draw_quad to draw some example shots
    x = 400
    y = 120
    draw_quad(x - 2, y, 0xffd936f1,
              x + 2, y, 0xffd936f1,
              x - 2, y + 20, 0xff000000,
	      x + 2, y + 20, 0xff000000, ZOrder::Shot)
	
	
    x = 400
    y = 220
    draw_quad(x - 4, y, 0xffaa0000,
	      x + 4, y, 0xffaa0000,
	      x - 4, y + 20, 0xffaacc00,
	      x + 4, y + 20, 0xffaacc00, ZOrder::Shot)
  ## here we use draw_rot to draw the ship centered at x,y 
  ## this makes it easier to  draw a shield around it
  ## if you're into that sort of thing
	 @ship_image.draw_rot(400, 360, ZOrder::Ship, 0)
  ## here we use draw_rot to draw rotAting image of the ship
  ## KALI MAAAAA
  angle = (Gosu::milliseconds / 15) % 360
 ## @shield_image.draw_rot(400, 360, ZOrder::Shot, angle, 0.5, 0.5, 0.75, 0.75,
 ## 0xff3366ff)
  end		 
  
  def button_down(id)
    case id
    when Gosu::KbEscape
      close  ## exit on press of escape key
    end
  end


end

window = GameWindow.new
window.show
