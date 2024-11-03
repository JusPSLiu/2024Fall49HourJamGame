extends Control

@export var resourceName: String
@export var baseMiningSpeedPerSec: float

@onready var resource = GridTileSingleton.get_tile(resourceName)
@onready var boop = $boop
@onready var beep = $beep

var started: bool = false
var progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$resourceTile/TextureRect.texture = resource.image

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !started:
		return
	progress += delta/baseMiningSpeedPerSec * 100
	$resourceTile/TextureProgressBar.value = clampf(progress,0,100)
	if progress >= 100:
		progress = 0
		$resourceTile/TextureProgressBar.value = progress
		started = false
		onHarvested()

func startHarvest():
	if started:
		return
	started = true
	progress = 0
	boop.play()

func onHarvested():
	GridTileSingleton.tileQuantities[resourceName] += 1
	GridTileSingleton.refreshAllTileQuantities()
	beep.play()
