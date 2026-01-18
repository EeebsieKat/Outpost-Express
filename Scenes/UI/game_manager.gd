extends Node

@export var max_fuel := 500

var player: Player

var lantern_state := true
var fuel_amount := 500
var fuel_drain := 1

var current_lantern_anim: String = ""

@onready var lantern: AnimatedSprite2D = $CanvasLayer/LanternOnOff
@onready var fuel_bar: TextureProgressBar = $CanvasLayer/FuelBar
@onready var fuel_timer: Timer = $CanvasLayer/FuelTimer

func _ready() -> void:
	call_deferred("_connect_player")
	fuel_timer.timeout.connect(_on_fuel_timer_timeout)
	fuel_timer.start()
	fuel_bar.max_value = max_fuel
	fuel_bar.value = fuel_amount
	#var check_timer = Timer.new()
	#add_child(check_timer)
	#check_timer.wait_time = 0.1
	#check_timer.one_shot = false
	#check_timer.autostart = true
	#check_timer.timeout.connect(_try_connect_player)

func _process(delta: float) -> void:
	pass

func _on_fuel_timer_timeout() -> void:
	change_fuel(-fuel_drain)

func change_fuel(amount: int) -> void:
	fuel_amount = clamp(fuel_amount + amount, 0, max_fuel)
	fuel_bar.value = fuel_amount
	print("Fuel:", fuel_amount)

	if fuel_amount <= 0:
		fuel_timer.stop()
		lantern_state = false

func _on_lantern_state_changed(state: bool) -> void:
	lantern_state = state

	if lantern_state:
		fuel_timer.stop()  # stop first, ensures restart
		fuel_timer.start() # restart fresh
	else:
		fuel_timer.stop()

	# Play animation based on state
	if state:
		lantern.play("on")
		current_lantern_anim = "on"
	else:
		lantern.play("off")
		current_lantern_anim = "off"

func _connect_player():
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0] as Player
		player.lantern_state_changed.connect(_on_lantern_state_changed)

#func _try_connect_player() -> void:
	#var players = get_tree().get_nodes_in_group("Player")
	#if players.size() > 0:
		#player = players[0] as Player
		#player.lantern_state_changed.connect(_on_lantern_state_changed)
		#print("Connected to Player signal!")
		#
		## Stop the timer
		#var timer = get_node("Timer") # or keep reference from _ready()
		#timer.stop()
		#timer.queue_free()
