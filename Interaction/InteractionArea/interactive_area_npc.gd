class_name InteractiveAreaNPC
extends Area2D

@onready var interactive_area: InteractiveAreaNPC = $"."

signal interaction_available
signal interaction_unavailable
signal interacted

var is_open := false

var package := load("res://Scenes/Objects/Packages/package_1.tscn")

@export var quest: Quest

@export var required_item: String

@export var interact_input_action := "interact"

var ballon_scene = preload("res://Dialogues/game_dialogue_ballon.tscn")

func _ready() -> void:
	interactive_area.interacted.connect(_on_interacted)
	set_process_unhandled_input(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(interact_input_action):
		interacted.emit()
		
func _on_interacted():
	if is_open:
		return

	is_open = true

	var balloon: BaseGameDialogueBalloon = ballon_scene.instantiate()
	get_tree().current_scene.add_child(balloon)

	balloon.dialogue_finished.connect(_on_dialogue_finished, CONNECT_ONE_SHOT)

	balloon.start(load("res://Dialogues/Conversations/Bejr.dialogue"), "start")

func _on_area_entered(area: Area2D) -> void:
	set_process_unhandled_input(true)
	interaction_available.emit()

func _on_area_exited(area: Area2D) -> void:
	set_process_unhandled_input(false)
	interaction_unavailable.emit()

func _on_dialogue_finished():
	is_open = false
	print("Dialogue ended from Bejr")
	spawn_or_finish_quest()

	
func spawn_or_finish_quest():
	if quest == null:
		print("QUEST VALUE:", quest)
		return

	match quest.quest_status:

		quest.QuestStatus.available:
			# START QUEST
			quest.start_quest()
			print("Quest Started:", quest)

			var new_package = package.instantiate()
			get_tree().current_scene.add_child(new_package)
			new_package.global_position = $Package1Spawnpoint.global_position

			var area := new_package.get_node("CollectableComponent") as Area2D
			area.quest = quest

		quest.QuestStatus.reached_goal:
			# FINISH QUEST
			if InventoryManager.has_item(required_item):
				InventoryManager.remove_item(required_item)
				quest.finish_quest()
				print("Delivered:", required_item)
			else:
				print("You don’t have", required_item)

		_:
			print("Quest state ignored:", quest.quest_status)
