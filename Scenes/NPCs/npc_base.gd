extends Area2D

@export var required_item: String

@export var quest: Quest

var ballon_scene = preload("res://Dialogues/game_dialogue_ballon.tscn")
var package := load("res://Scenes/Objects/Packages/package_1.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var ballon: BaseGameDialogueBalloon = ballon_scene.instantiate()
		get_tree().current_scene.add_child(ballon)
		ballon.start(load("res://Dialogues/Conversations/test_dialogue.dialogue"), "start")
		
		if quest.quest_status == quest.QuestStatus.available:
			quest.start_quest()
			print("Quest Started: ", quest)
			var new_package = package.instantiate()
			add_child(new_package)
			new_package.position = $Package1Spawnpoint.position
			
			var area := new_package.get_node("CollectableComponent") as Area2D
			area.quest = quest
			
		if quest.quest_status == quest.QuestStatus.reached_goal:
			quest.finish_quest()
			
		if InventoryManager.has_item(required_item):
			InventoryManager.remove_item(required_item)
			print("Delivered:", required_item)
			# Optional: reward player here
		else:
			print("You don’t have", required_item)
