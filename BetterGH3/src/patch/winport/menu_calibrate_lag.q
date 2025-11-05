calibrate_lag_menu_font = fontgrid_title_gh3
calibrate_lag_menu_line_pos = (420.0, 360.0)
calibrate_lag_menu_circle_dims = (96.0, 96.0)
calibrate_lag_menu_circle_velocity = 300
calibrate_lag_menu_circle_inital_pos = (420.0, -146.0)
calibrate_lag_menu_circle_separation = 320
calibrate_lag_menu_num_circles = 15
calibrate_lag_hilite_pos0 = (615.0, 401.0)
calibrate_lag_hilite_dims0 = (490.0, 50.0)
calibrate_lag_hilite_pos1 = (615.0, 458.0)
calibrate_lag_hilite_dims1 = (490.0, 50.0)
calibrate_lag_hilite_pos2 = (615.0, 508.0)
calibrate_lag_hilite_dims2 = (490.0, 50.0)
calibrate_lag_hilite_pos3 = (625.0, 556.0)
calibrate_lag_hilite_dims3 = (480.0, 50.0)
calibrate_lag_hilite_unselected = [
	40
	100
	165
	255
]
calibrate_lag_hilite_selected = [
	165
	95
	50
	255
]
calibrate_lag_results = [
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
]
calibrate_lag_circle_index = 0
calibrate_lag_real_time_requirement = 0
calibrate_lag_dirty = 0
calibrate_lag_end_checks = 0
calibrate_lag_started_finish = 0
calibrate_lag_cap_upper = 1000
calibrate_lag_cap_lower = -1000
calibrate_lag_early_window = -150
calibrate_lag_late_window = 400
cl_ready_for_input = 0
calibrate_lag_most_recent_in_game_setting = 0
calibrate_lag_section = none

script create_calibrate_lag_dialog_menu 
	if gotparam \{dialog_1}
		setup_calibration_lag_dialog_1
	elseif gotparam \{dialog_2}
		setup_calibration_lag_dialog_2
	endif
	if ($calibrate_lag_most_recent_in_game_setting = 1)
		<controller> = ($last_start_pressed_device)
	else
		<controller> = ($primary_controller)
	endif
	create_calibrate_background \{z = 80}
	memcard_cleanup_messages
	create_popup_warning_menu {
		player_device = <controller>
		no_background
		title = <title_text>
		textblock = {
			text = <body_text>
			dims = (800.0, 400.0)
			scale = 0.5
		}
		menu_pos = (640.0, 490.0)
		dialog_dims = (288.0, 64.0)
		helper_pills = [select]
		options = [
			{
				func = {ui_flow_manager_respond_to_action params = {action = continue}}
				text = $menu_calibrate_lag_continue
				scale = (1.0, 1.0)
			}
		]
	}
endscript

script create_calibrate_lag_menu \{from_in_game = 1}
	change \{disable_menu_sounds = 1}
	change calibrate_lag_most_recent_in_game_setting = <from_in_game>
	if iswinport
		if ($calibrate_lag_most_recent_in_game_setting = 1)
			kill_start_key_binding
		endif
	else
		kill_start_key_binding
	endif
	menu_music_off
	if viewportexists \{id = bg_viewport}
		disable_bg_viewport
	endif
	change \{calibrate_lag_end_checks = 0}
	change \{calibrate_lag_started_finish = 0}
	set_focus_color \{rgba = [
			230
			230
			230
			255
		]}
	set_unfocus_color \{rgba = $calibrate_lag_hilite_unselected}
	z = 100
	create_calibrate_background <...>
	calibrate_lag_fill_options z = <z> from_in_game = <from_in_game>
	if NOT screenelementexists \{id = cl_container}
		return
	endif
	displaysprite {
		parent = cl_container
		id = calibrate_lag_target
		tex = options_calibrate_target
		pos = ($calibrate_lag_menu_line_pos + ($calibrate_lag_menu_circle_dims * 0.5))
		just = [center center]
		dims = (96.0, 96.0)
		z = (<z> + 50)
		alpha = 0.75
	}
	displaysprite \{parent = cl_container
		id = cl_ping_id
		tex = options_audio_ping
		alpha = 0
		scale = 5
		z = 180
		just = [
			center
			center
		]
		pos = (468.0, 406.0)}
	cl_ping_id :domorph \{alpha = 0}
	change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	add_user_control_helper \{text = $buttons_select
		button = green
		z = 100}
	add_user_control_helper \{text = $buttons_back
		button = red
		z = 100}
	add_user_control_helper \{text = $buttons_up_down
		button = strumbar
		z = 100}
	if ($calibrate_lag_section = none)
		launchevent \{type = focus
			target = cl_vmenu}
	endif
	if ($calibrate_lag_section = video)
		launchevent \{type = pad_choose
			target = calibrate_calibrate_option}
	elseif ($calibrate_lag_section = audio)
		launchevent \{type = pad_choose
			target = calibrate_calibrate_option}
	endif
	change \{disable_menu_sounds = 0}
endscript

script create_calibrate_background 
	createscreenelement \{type = containerelement
		parent = root_window
		id = cl_container
		pos = (0.0, 0.0)}
	create_menu_backdrop \{texture = venue_bg}
	displaysprite {
		parent = cl_container
		tex = venue_bg
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [center center]
		z = (<z> - 4)
	}
	createscreenelement {
		type = spriteelement
		parent = cl_container
		id = as_light_overlay
		texture = venue_overlay
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [center center]
		z_priority = (<z> - 1)
	}
	displaysprite {
		parent = cl_container
		tex = options_calibrate_poster
		pos = (250.0, 0.0)
		dims = (432.0, 954.0)
		z = <z>
	}
	displaysprite {
		parent = cl_container
		tex = options_calibrate_paper
		pos = (600.0, -100.0)
		dims = (610.0, 892.0)
		z = (<z> -2)
	}
	displaysprite {
		parent = cl_container
		tex = toprockers_tape_2
		pos = (720.0, -100.0)
		dims = (180.0, 80.0)
		z = (<z> + 2)
		rot_angle = 93
	}
	displaysprite {
		parent = cl_container
		tex = toprockers_tape_2
		rgba = [0 0 0 128]
		pos = (725.0, -102.0)
		dims = (180.0, 80.0)
		z = (<z> + 2)
		rot_angle = 93
	}
	<tape_offset> = (90.0, 325.0)
	displaysprite {
		parent = cl_container
		tex = tape_v_01
		pos = ((970.0, 106.0) + <tape_offset>)
		dims = (96.0, 192.0)
		z = (<z> + 2)
		flip_v
		rot_angle = -6
	}
	displaysprite {
		parent = cl_container
		tex = tape_v_01
		rgba = [0 0 0 128]
		pos = ((975.0, 104.0) + <tape_offset>)
		dims = (96.0, 192.0)
		z = (<z> + 2)
		flip_v
		rot_angle = -6
	}
	displaysprite {
		parent = cl_container
		tex = tape_h_02
		pos = (220.0, 566.0)
		dims = (132.0, 64.0)
		z = (<z> + 2)
		rot_angle = 8
	}
	displaysprite {
		parent = cl_container
		tex = tape_h_02
		rgba = [0 0 0 128]
		pos = (212.0, 572.0)
		dims = (132.0, 64.0)
		z = (<z> + 2)
		rot_angle = 8
	}
	displaytext \{parent = cl_container
		text = $menu_calibrate_lag_hdtv_lag
		pos = (770.0, 80.0)
		font = fontgrid_title_gh3
		rgba = [
			0
			0
			0
			255
		]
		noshadow}
	upper_helper = $menu_calibrate_lag_pc_setups
	createscreenelement {
		type = textblockelement
		parent = cl_container
		pos = (700.0, 80.0)
		text = <upper_helper>
		font = text_a6
		dims = (575.0, 0.0)
		allow_expansion
		rgba = [60 40 115 255]
		scale = 0.56
		just = [left top]
		internal_just = [left top]
		z_priority = <z>
	}
	getscreenelementdims id = <id>
	getscreenelementposition id = <id>
endscript

script calibrate_lag_fill_options \{z = 100}
	if (<from_in_game>)
		<controller> = ($last_start_pressed_device)
	else
		<controller> = ($primary_controller)
	endif
	createscreenelement {
		type = spriteelement
		parent = cl_container
		id = calibrate_lag_hilite
		texture = options_calibrate_hilite
		just = [left top]
		pos = $calibrate_lag_hilite_pos0
		rgba = $calibrate_lag_hilite_unselected
		z_priority = <z>
	}
	calib_eh = [
		{pad_back menu_calibrate_go_back}
	]
	new_menu {
		scrollid = cl_scroll
		vmenuid = cl_vmenu
		menu_pos = (700.0, 435.0)
		event_handlers = <calib_eh>
		exclusive_device = <controller>
		text_left
		default_colors = 0
		spacing = -5
		no_focus = 1
	}
	wait \{2
		gameframes}
	text_params = {parent = cl_vmenu type = textelement font = ($calibrate_lag_menu_font) rgba = ($menu_unfocus_color) scale = 0.9}
	if NOT screenelementexists \{id = cl_vmenu}
		return
	endif
	createscreenelement {
		<text_params>
		id = calibrate_reset_option
		text = $menu_calibrate_lag_reset
		event_handlers = [
			{focus menu_calibrate_focus params = {index = 1}}
			{unfocus menu_calibrate_unfocus params = {index = 1}}
			{pad_choose menu_calibrate_lag_reset_lag params = {z = <z>}}
		]
		z_priority = (<z> + 1)
	}
	getscreenelementdims id = <id>
	fit_text_in_rectangle id = <id> dims = ((340.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1
	createscreenelement \{type = containerelement
		parent = cl_vmenu
		id = calibrate_manual_option_audio
		event_handlers = [
			{
				focus
				menu_calibrate_focus
				params = {
					index = 2
				}
			}
			{
				unfocus
				menu_calibrate_unfocus
				params = {
					index = 2
				}
			}
			{
				pad_choose
				menu_calibrate_lag_manual_choose
				params = {
					audio
				}
			}
		]}
	<container_id> = <id>
	createscreenelement {
		<text_params>
		parent = <container_id>
		id = lag_offset_text_audio
		text = " "
		just = [left top]
		z_priority = (<z> + 1)
		pos = (40.0, 0.0)
	}
	createscreenelement {
		type = spriteelement
		id = cl_manual_adjust_up_arrow_audio
		parent = <container_id>
		texture = online_arrow
		just = [center bottom]
		pos = (16.0, 16.0)
		rgba = ($calibrate_lag_hilite_unselected)
		alpha = 1
		scale = 0.65000004
		z_priority = (<z> + 1)
		flip_h
	}
	createscreenelement {
		type = spriteelement
		id = cl_manual_adjust_down_arrow_audio
		parent = <container_id>
		texture = online_arrow
		just = [center top]
		pos = (16.0, 20.0)
		rgba = ($calibrate_lag_hilite_unselected)
		alpha = 1
		scale = 0.65000004
		z_priority = (<z> + 1)
	}
	createscreenelement \{type = containerelement
		parent = cl_vmenu
		id = calibrate_manual_option
		event_handlers = [
			{
				focus
				menu_calibrate_focus
				params = {
					index = 3
				}
			}
			{
				unfocus
				menu_calibrate_unfocus
				params = {
					index = 3
				}
			}
			{
				pad_choose
				menu_calibrate_lag_manual_choose
			}
		]}
	<container_id> = <id>
	createscreenelement {
		<text_params>
		parent = <container_id>
		id = lag_offset_text
		text = " "
		just = [left top]
		z_priority = (<z> + 1)
		pos = (40.0, 52.0)
	}
	calibrate_lag_update_text
	createscreenelement {
		type = spriteelement
		id = cl_manual_adjust_up_arrow
		parent = <container_id>
		texture = online_arrow
		just = [center bottom]
		pos = (16.0, 68.0)
		rgba = ($calibrate_lag_hilite_unselected)
		alpha = 1
		scale = 0.65000004
		z_priority = (<z> + 1)
		flip_h
	}
	createscreenelement {
		type = spriteelement
		id = cl_manual_adjust_down_arrow
		parent = <container_id>
		texture = online_arrow
		just = [center top]
		pos = (16.0, 72.0)
		rgba = ($calibrate_lag_hilite_unselected)
		alpha = 1
		scale = 0.65000004
		z_priority = (<z> + 1)
	}
	setscreenelementlock \{id = cl_vmenu
		on}
endscript

script calibrate_lag_update_text
	getglobaltags \{user_options}
	casttointeger \{lag_audio}
	casttointeger \{lag_video}
	formattext textname = lag_value_text $menu_calibrate_lag_audio_ms d = <lag_audio>
	lag_offset_text_audio :setprops text = <lag_value_text>
	formattext textname = lag_value_text $menu_calibrate_lag_video_ms d = <lag_video>
	lag_offset_text :setprops text = <lag_value_text>
endscript

script destroy_calibrate_lag_menu 
	spawnscriptnow \{menu_music_on}
	if viewportexists \{id = bg_viewport}
		enable_bg_viewport
	endif
	change \{calibrate_lag_dirty = 0}
	destroy_menu_backdrop
	clean_up_user_control_helpers
	killspawnedscript \{name = do_calibration_update}
	destroy_menu \{menu_id = cl_scroll}
	destroy_menu \{menu_id = cl_container}
	if screenelementexists \{idcl_manual_adjust_handler}
		destroyscreenelement \{id = cl_manual_adjust_handler}
	endif
	launchevent \{type = focus
		target = root_window}
endscript

script menu_calibrate_focus 
	generic_menu_up_or_down_sound
	wait \{1
		gameframe}
	if (<index> = 0)
		retail_menu_focus
		setscreenelementprops \{id = calibrate_lag_hilite
			pos = $calibrate_lag_hilite_pos0
			dims = $calibrate_lag_hilite_dims0}
	elseif (<index> = 1)
		retail_menu_focus
		setscreenelementprops \{id = calibrate_lag_hilite
			pos = $calibrate_lag_hilite_pos1
			dims = $calibrate_lag_hilite_dims1}
	elseif (<index> = 2)
		obj_getid
		retail_menu_focus id = {<objid> child = 0}
		setscreenelementprops \{id = calibrate_lag_hilite
			pos = $calibrate_lag_hilite_pos2
			dims = $calibrate_lag_hilite_dims2}
		doscreenelementmorph \{id = cl_manual_adjust_up_arrow_audio
			rgba = $menu_focus_color}
		doscreenelementmorph \{id = cl_manual_adjust_down_arrow_audio
			rgba = $menu_focus_color}
	else
		obj_getid
		retail_menu_focus id = {<objid> child = 0}
		setscreenelementprops \{id = calibrate_lag_hilite
			pos = $calibrate_lag_hilite_pos3
			dims = $calibrate_lag_hilite_dims3}
		doscreenelementmorph \{id = cl_manual_adjust_up_arrow
			rgba = $menu_focus_color}
		doscreenelementmorph \{id = cl_manual_adjust_down_arrow
			rgba = $menu_focus_color}
	endif
endscript

script menu_calibrate_unfocus 
	if (<index> = 0)
		retail_menu_unfocus
	elseif (<index> = 1)
		retail_menu_unfocus
	elseif (<index> = 2)
		obj_getid
		retail_menu_unfocus id = {<objid> child = 0}
		doscreenelementmorph id = cl_manual_adjust_up_arrow_audio rgba = ($calibrate_lag_hilite_unselected)
		doscreenelementmorph id = cl_manual_adjust_down_arrow_audio rgba = ($calibrate_lag_hilite_unselected)
	else
		obj_getid
		retail_menu_unfocus id = {<objid> child = 0}
		doscreenelementmorph id = cl_manual_adjust_up_arrow rgba = ($calibrate_lag_hilite_unselected)
		doscreenelementmorph id = cl_manual_adjust_down_arrow rgba = ($calibrate_lag_hilite_unselected)
	endif
endscript

script menu_calibrate_lag_reset_lag
	generic_menu_up_or_down_sound
	getglobaltags \{user_options}
	setglobaltags \{user_options
		params = {
			lag_audio = 0.0
			lag_video = 0.0
		}}
	calibrate_lag_update_text
	change \{calibrate_lag_dirty = 1}
endscript

script menu_calibrate_lag_manual_choose 
	setscreenelementprops \{id = calibrate_lag_hilite
		rgba = $calibrate_lag_hilite_selected}
	runscriptonscreenelement \{id = calibrate_lag_hilite
		pulse_lag_hilite}
	setscreenelementprops \{id = cl_vmenu
		block_events}
	createscreenelement {
		type = containerelement
		parent = cl_container
		id = cl_manual_adjust_handler
		event_handlers = [
			{pad_up menu_calibrate_lag_manual_up params = {<...>}}
			{pad_down menu_calibrate_lag_manual_down params = {<...>}}
			{pad_choose menu_calibrate_lag_manual_back}
			{pad_back menu_calibrate_lag_manual_back}
		]
	}
	launchevent \{type = focus
		target = cl_manual_adjust_handler}
	generic_menu_pad_choose_sound
endscript

script pulse_lag_hilite 
	begin
	getscreenelementprops \{id = calibrate_lag_hilite}
	match_rgba rgba1 = <rgba> rgba2 = $calibrate_lag_hilite_selected
	if (<rgba_match> = 1)
		domorph \{id = calibrate_lag_hilite
			alpha = 0.6
			time = 0.4
			motion = ease_out}
		domorph \{id = calibrate_lag_hilite
			alpha = 1
			time = 0.6
			motion = ease_in}
	else
		domorph \{id = calibrate_lag_hilite
			alpha = 1
			time = 0.2
			motion = ease_out}
		break
	endif
	repeat
endscript

script menu_calibrate_lag_manual_back 
	setscreenelementprops \{id = calibrate_lag_hilite
		rgba = $calibrate_lag_hilite_unselected}
	setscreenelementprops \{id = cl_vmenu
		unblock_events}
	destroyscreenelement \{id = cl_manual_adjust_handler}
	generic_menu_pad_choose_sound
endscript

script menu_calibrate_lag_manual_up 
	do_morph = 0
	if gotparam \{audio}
		arrow_id = cl_manual_adjust_up_arrow_audio
		if menu_calibrate_lag_adjust \{value = 1
				for_audio = 1}
			do_morph = 1
		endif
	else
		arrow_id = cl_manual_adjust_up_arrow
		if menu_calibrate_lag_adjust \{value = 1}
			do_morph = 1
		endif
	endif
	if (<do_morph> = 1)
		doscreenelementmorph id = <arrow_id> scale = 1.5 relative_scale
		doscreenelementmorph id = <arrow_id> scale = 1.0 relative_scale time = 0.15
	endif
	generic_menu_up_or_down_sound
endscript

script menu_calibrate_lag_manual_down 
	do_morph = 0
	if gotparam \{audio}
		arrow_id = cl_manual_adjust_down_arrow_audio
		if menu_calibrate_lag_adjust \{value = -1
				for_audio = 1}
			do_morph = 1
		endif
	else
		arrow_id = cl_manual_adjust_down_arrow
		if menu_calibrate_lag_adjust \{value = -1}
			do_morph = 1
		endif
	endif
	if (<do_morph> = 1)
		doscreenelementmorph id = <arrow_id> scale = 1.5 relative_scale
		doscreenelementmorph id = <arrow_id> scale = 1.0 relative_scale time = 0.15
	endif
	generic_menu_up_or_down_sound
endscript

script menu_calibrate_lag_adjust \{value = 1
		for_audio = 0}
	getglobaltags \{user_options}
	<audio_calibration> = <lag_audio>
	casttointeger \{audio_calibration}
	<video_calibration> = <lag_video>
	casttointeger \{video_calibration}
	if (<for_audio> = 1)
		<audio_calibration> = (<audio_calibration> + <value>)
		if (<audio_calibration> > $calibrate_lag_cap_upper)
			<audio_calibration> = $calibrate_lag_cap_upper
		elseif (<audio_calibration> < $calibrate_lag_cap_lower)
			<audio_calibration> = $calibrate_lag_cap_lower
		endif
	else
		<video_calibration> = (<video_calibration> + <value>)
		if (<video_calibration> > $calibrate_lag_cap_upper)
			<video_calibration> = $calibrate_lag_cap_upper
		elseif (<video_calibration> < $calibrate_lag_cap_lower)
			<video_calibration> = $calibrate_lag_cap_lower
		endif
	endif
	change \{calibrate_lag_dirty = 1}
	setglobaltags user_options params = {lag_audio = <audio_calibration>}
	setglobaltags user_options params = {lag_video = <video_calibration>}
	calibrate_lag_update_text
	return \{true}
endscript
