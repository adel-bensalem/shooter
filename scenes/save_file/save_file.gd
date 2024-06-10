extends Node2D

@export var filename: String = "shooter.save":
	set(name):
		filename = name
		location = "user://" + name
@export var loaded_save = {}

var location = "user://shooter.save"

func load_save():
	if not FileAccess.file_exists(location):
		return

	var save_file = FileAccess.open(location, FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		loaded_save = json.get_data()
		
	return loaded_save

func save(data: Dictionary):
	var save_file = FileAccess.open(location, FileAccess.WRITE)	
	var save_data = {}
	
	save_data.merge(loaded_save)
	save_data.merge(data, true)
	save_file.store_line(JSON.stringify(save_data))
	loaded_save = save_data
	
	return save_data

func get_save():
	return loaded_save
	
func get_save_data(key: String, default_value):
	return loaded_save["volume"] if loaded_save.has(key) else default_value
