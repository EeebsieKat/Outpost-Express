class_name Quest
extends QuestManager

func start_quest() -> void:
	if quest_status == QuestStatus.available:
		quest_status = QuestStatus.started
		
		QuestBox.visible = true
		QuestTitle.text = quest_name
		QuestDescription.text = quest_description
		
func reached_goal() -> void:
	if quest_status == QuestStatus.started:
		quest_status = QuestStatus.reached_goal
		QuestDescription.text = reached_goal_text
		
func finish_quest() -> void:
	if quest_status == QuestStatus.reached_goal:
		quest_status = QuestStatus.finished
		
		QuestBox.visible = false
		
		GameManager.change_fuel(500)
