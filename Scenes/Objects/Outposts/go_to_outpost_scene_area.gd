extends Area2D

@export var target_scene: PackedScene

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		get_tree().change_scene_to_packed(target_scene)
