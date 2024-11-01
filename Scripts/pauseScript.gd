extends CanvasLayer

@export var PauseyArea : TextureRect
@export var AnimatPlayr : AnimationPlayer
@export var Bumpscositext : Label
@export var musicSlider : HSlider
@export var soundSlider : HSlider

var loadingStateChange : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var musicVolume : float = AudioServer.get_bus_volume_db(2)
	var soundVolume : float = AudioServer.get_bus_volume_db(1)
	#set to music and sound variables iff not null
	if (musicVolume != null):
		musicSlider.value = (db_to_linear(musicVolume))
	if (soundVolume != null):
		soundSlider.value = (db_to_linear(soundVolume))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pause_button_pressed():
	if (!loadingStateChange):
		$TextureRect/AudioStreamPlayer.play()
		loadingStateChange = true
		if (!get_tree().paused):
			get_tree().paused = true
			PauseyArea.visible = true
			AnimatPlayr.play("toPause")
		else:
			AnimatPlayr.play("out")
			await AnimatPlayr.animation_finished
			get_tree().paused = false
			PauseyArea.visible = false
		loadingStateChange = false


func _on_h_slider_value_changed(value):
	match(int(value)):
		0:
			Bumpscositext.text = "0"
		1:
			Bumpscositext.text = "1"
		2:
			Bumpscositext.text = "12"
		3:
			Bumpscositext.text = "50"
		4:
			Bumpscositext.text = "76"
		5:
			Bumpscositext.text = "100"
		6:
			Bumpscositext.text = "1000"
		_:
			Bumpscositext.text = "99999999999999"


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))


func _on_sound_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
