extends RayCast3D

var pickup_item: Interactable

func _process(delta):
	if is_colliding():
		var detected = get_collider()
		if detected is Interactable:
			if detected.object_type == detected.ObjectType.Item:
				pickup_item = detected
				%Pointer.text = "拾う"
			elif detected.object_type == detected.ObjectType.Look:
				pickup_item = detected
				if !pickup_item.looking:
					%Pointer.text = "見る"
		else:
			if pickup_item && !pickup_item.looking:
				%Pointer.text = "・"
				pickup_item = null
	else:
		if pickup_item && !pickup_item.looking:
			%Pointer.text = "・"
			pickup_item = null
		
	if pickup_item && Input.is_action_just_pressed("pickup"):
		match pickup_item.object_type:
			pickup_item.ObjectType.Item:
				pickup_item.queue_free()
				%Pointer.text = "・"
				if pickup_item.dialog_player.size() > 0:
					%Dialog.start_dialog(pickup_item.dialog_player)
				pickup_item = null
			pickup_item.ObjectType.Look:
				if pickup_item.looking:
					%BG.visible = false
					pickup_item.return_object()
				else:
					%Pointer.text = ""
					%BG.visible = true
					%Name.text = pickup_item.object_name
					%Description.text = pickup_item.description
					pickup_item.look_object()
