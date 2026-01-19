extends Node2D
class_name HitVisualEffect

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.2
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func toggle_visibility(visible: bool) -> void:
	if visible:
		self.visible = true
		timer.start()
	else:
		self.visible = false
		timer.stop()

func _on_timer_timeout() -> void:
	visible = false
