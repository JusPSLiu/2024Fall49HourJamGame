extends Control

@export var resourceNames: Array[String]
@export var baseMiningSpeedPerSec: float
@export var batchSize: int = 1
@export var neededResource: String = ""
@export var autoHarvesters: Array = [
	{ "resourceName": "sample", "baseHarvestSpeedPerSec": 1, "minHarvestSpeedPerSec": 0.2}
]

@onready var resources : Array
@onready var boop = $boop
@onready var beep = $beep

var currentResource = 0
var gotNeededResource = false
var started: bool = false
var progress = 0
var miningSpeed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if neededResource != "":
		$TextureRect.disabled = true
	else:
		gotNeededResource = true
	miningSpeed = baseMiningSpeedPerSec
	for name in resourceNames:
		resources.push_back(GridTileSingleton.get_tile(name))
	$resourceTile/TextureRect.texture = resources[0].image
	#if (OS.is_debug_build()):
	#	baseMiningSpeedPerSec *= 0.001
	#	batchSize *= 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gotNeededResource == false:
		if GridTileSingleton.tileQuantities[neededResource] == 0:
			return
		else:
			gotNeededResource = true
			$TextureRect.disabled = false
	if !started:
		return
	progress += delta/miningSpeed * 100
	$resourceTile/TextureProgressBar.value = clampf(progress,0,100)
	if progress >= 100:
		progress = 0
		$resourceTile/TextureProgressBar.value = progress
		started = false
		onHarvested()
		checkAutoHarvesters()

func checkAutoHarvesters():
	for i in range(autoHarvesters.size() - 1, -1,-1):
		var item = autoHarvesters[i]
		var q = GridTileSingleton.tileQuantities[item["resourceName"]]
		if q > 0:
			var bhsps : float = item["baseHarvestSpeedPerSec"]
			var mhsps : float = item["minHarvestSpeedPerSec"]
			miningSpeed = maxf(bhsps/q, mhsps)
			startHarvest()
			return

func startHarvest():
	if started:
		return
	started = true
	progress = 0
	boop.play()

func onHarvested():
	GridTileSingleton.tileQuantities[resourceNames[currentResource]] += batchSize
	GridTileSingleton.refreshAllTileQuantities()
	beep.play()
	if (resourceNames.size() > 0):
		var prevRsc = currentResource
		currentResource = randi_range(0,resourceNames.size()-1)
		if (currentResource != prevRsc):
			$resourceTile/TextureRect.texture = resources[currentResource].image
