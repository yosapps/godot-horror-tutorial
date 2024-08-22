extends RayCast3D

var pickup_item

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
			%Pointer.text = "・"
			pickup_item = null
	else:
		%Pointer.text = "・"
		pickup_item = null
		
	if pickup_item && Input.is_action_just_pressed("pickup"):
		match pickup_item.object_type:
			pickup_item.ObjectType.Item:
				pickup_item.queue_free()
				pickup_item = null
			pickup_item.ObjectType.Look:
				if pickup_item.looking:
					pickup_item.return_object()
				else:
					%Pointer.text = ""
					pickup_item.look_object()
