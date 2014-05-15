##this is my first ruby game!!
##go ruby go!!
##
## Gosu only supports two image types, BMP and PNG so keep that in mind!
##

require 'rubygems'
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
	 self.caption = 'Go Graphics Go'

   	 @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
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
	 @ship_image = Gosu::Image.new(self, "", false)




   end
  
  	def update
    	@counter += 1
   end
  
  	def draw
    	@font.draw(@counter, 0, 0, 1)
   end
  
  	def button_down(id)
    	if id == Gosu::KbEscape
      	close  ## exit on press of escape key
    end
  end



end

window = GameWindow.new
window.show
