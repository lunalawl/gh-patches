// Turn the audio lag reminder into a resolution set reminder
script winport_create_audio_calibrate_reminder 
	WinPortGetConfigNumber \{name = $boot_flow_audiolagremindershown
		defaultValue = 0}
	if (<value> = 1)
		ui_flow_manager_respond_to_action \{action = continue}
		return
	endif
	WinPortSetConfigNumber \{name = $boot_flow_audiolagremindershown
		value = 1}
	z = 100
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = winport_cl_container
		pos = (0.0, 0.0)}
	create_menu_backdrop \{texture = Venue_BG}
	displaySprite {
		parent = winport_cl_container
		tex = Venue_BG
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [center center]
		z = (<z> - 4)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = winport_cl_container
		id = as_light_overlay
		texture = venue_overlay
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [center center]
		z_priority = (<z> - 1)
	}
	displaySprite {
		parent = winport_cl_container
		tex = Audio_calib_reminder_amp
		pos = (540.0, 340.0)
		just = [center center]
		scale = 1.42
		z = (<z> -2)
	}
	textProps = {
		type = TextBlockElement
		parent = winport_cl_container
		font = text_a4
		rgba = [0 21 132 255]
		z_priority = <z>
		just = [center center]
		internal_just = [center center]
	}
	CreateScreenElement {
		<textProps>
		pos = (640.0, 270.0)
		dims = (500.0, 500.0)
		text = $boot_flow_default_resolution
		scale = 0.8
	}
	CreateScreenElement {
		<textProps>
		pos = (640.0, 420.0)
		dims = (650.0, 500.0)
		text = $boot_flow_set_resolution_display
		scale = 0.7
	}
	spawnscriptnow \{check_for_any_input
		params = {
			use_primary_controller
			button1 = start
			button2 = x
		}}
endscript
