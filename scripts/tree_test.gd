
extends Tree

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	set_columns(5)
	
	set_column_titles_visible(true)
	
	set_anchor_and_margin(MARGIN_LEFT,ANCHOR_BEGIN,5)
	set_anchor_and_margin(MARGIN_RIGHT,ANCHOR_END,5)
	set_anchor_and_margin(MARGIN_TOP,ANCHOR_BEGIN,30)
	set_anchor_and_margin(MARGIN_BOTTOM,ANCHOR_END,5)

	
	
	set_column_title(0,"Name")
	set_column_title(1,"Preview")
	set_column_title(2,"Format")
	set_column_title(3,"dB")
	set_column_title(4,"PScale")
	
	set_column_min_width(1,150)
	set_column_min_width(2,100)
	set_column_min_width(3,50)
	set_column_min_width(4,50)
	set_column_expand(0, true)
	set_column_expand(1,false)
	set_column_expand(2,false)
	set_column_expand(3,false)
	set_column_expand(4,false)

	set_size(Vector2(975, 364))

	
	pass


