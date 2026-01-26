extends Node

#===============================================
#			Scripts for npcs
#===============================================

func _on_dialogue_ended_give_package():
	print("Function is called after dialogue")
	get_tree().call_group("spawn_package", "spawn_package")
