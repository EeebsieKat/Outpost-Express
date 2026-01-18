extends Node

var inventory: Array = []

# Add an item to inventory
func add_collectable(item_name: String) -> void:
	inventory.append(item_name)
	print("Inventory now:", inventory)

# Check if player has an item
func has_item(item_name: String) -> bool:
	return item_name in inventory

# Remove an item (for delivery)
func remove_item(item_name: String) -> void:
	inventory.erase(item_name)
	print("Inventory now:", inventory)
