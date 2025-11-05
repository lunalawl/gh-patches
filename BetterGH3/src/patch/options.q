// Options prompt save on exit when changed
options_select_option_fs = {
	create = create_options_menu
	destroy = destroy_options_menu
	actions = [
		{
			action = select_audio_settings
			flow_state = options_audio_settings_fs
			transition_right
		}
		{
			action = select_gfx_settings
			flow_state = options_gfx_settings_fs
			transition_right
		}
		{
			action = select_calibrate_lag
			flow_state = options_calibrate_lag_fs
			transition_right
		}
		{
			action = winport_select_calibrate_lag
			flow_state = winport_options_calibrate_lag_fs
			transition_right
		}
		{
			action = select_controller_settings
			flow_state = options_controller_settings_fs
			transition_right
		}
		{
			action = select_manage_band
			flow_state = options_choose_band_fs
			transition_right
		}
		{
			action = select_data_settings
			flow_state = options_data_settings_fs
			transition_right
		}
		{
			action = select_bonus_videos
			flow_state = options_bonus_videos_fs
			transition_right
		}
		{
			action = select_credits
			flow_state = options_credits_fs
			transition_right
		}
		{
			action = select_store
			flow_state = options_choose_band_for_store_fs
			transition_right
		}
		{
			action = select_top_rockers
			func = options_prepare_for_top_rockers
			flow_state = options_top_rockers_difficulty_select_fs
			transition_right
		}
		{
			action = select_cheats
			flow_state = options_cheats_fs
			transition_right
		}
		{
			action = select_auto_login
			flow_state = options_login_settings_fs
			transition_right
		}
		{
			action = go_back
			flow_state_func = select_option_maybe_autosave
			transition_left
		}
	]
}

select_option_autosave_fs = {
	create = memcard_sequence_begin_autosave
	destroy = memcard_sequence_cleanup_generic
	actions = [
		{
			action = memcard_sequence_save_success
			flow_state = main_menu_fs
			transition_left
		}
		{
			action = memcard_sequence_save_failed
			flow_state = main_menu_fs
			transition_left
		}
	]
}

options_autosave_required = 0

script select_option_maybe_autosave 
	if ($options_autosave_required = 1)
		change \{options_autosave_required = 0}
		return \{flow_state = select_option_autosave_fs}
	else
		return \{flow_state = main_menu_fs}
	endif
endscript



// AUDIO
script ChangeSpinalTapVolume \{spinal_tap_volume_max = 11}
	<spinal_tap_volume> = (<spinal_tap_volume> + <change>)
	if (<spinal_tap_volume> < 0)
		<spinal_tap_volume> = 0
	elseif (<spinal_tap_volume> > <spinal_tap_volume_max>)
		<spinal_tap_volume> = <spinal_tap_volume_max>
	endif
	change \{options_autosave_required = 1}
	return volume = <spinal_tap_volume>
endscript



// CONTROLLER
script controller_settings_menu_choose_lefty_flip_p1 
	if (<popup>)
		ui_flow_manager_respond_to_action \{action = select_lefty_flip
			create_params = {
				player = 1
			}}
	else
		GetGlobalTags \{user_options}
		if (<lefty_flip_p1> = 1)
			<lefty_flip_p1> = 0
			SoundEvent \{event = checkbox_sfx}
		else
			<lefty_flip_p1> = 1
			SoundEvent \{event = CheckBox_Check_SFX}
		endif
		SetGlobalTags user_options params = {lefty_flip_p1 = <lefty_flip_p1>}
		controller_settings_menu_update_lefty_flip_p1_value lefty_flip_p1 = <lefty_flip_p1>
		change \{options_autosave_required = 1}
	endif
endscript

script controller_settings_menu_choose_lefty_flip_p2 
	if (<popup>)
		ui_flow_manager_respond_to_action \{action = select_lefty_flip
			create_params = {
				player = 2
			}}
	else
		GetGlobalTags \{user_options}
		if (<lefty_flip_p2> = 1)
			<lefty_flip_p2> = 0
			SoundEvent \{event = checkbox_sfx}
		else
			<lefty_flip_p2> = 1
			SoundEvent \{event = CheckBox_Check_SFX}
		endif
		SetGlobalTags user_options params = {lefty_flip_p2 = <lefty_flip_p2>}
		controller_settings_menu_update_lefty_flip_p2_value lefty_flip_p2 = <lefty_flip_p2>
		change \{options_autosave_required = 1}
	endif
endscript

script menu_whammy_bar_calibration_enter_sample 
	if GuitarGetAnalogueInfo controller = <device_num>
		if (<rightx> = 0)
			<rightx> = 0.0001
		elseif (<rightx> = 1)
			<rightx> = 0.9998999
		endif
		switch (<device_num>)
			case 0
			SetGlobalTags user_options params = {resting_whammy_position_device_0 = <rightx>}
			case 1
			SetGlobalTags user_options params = {resting_whammy_position_device_1 = <rightx>}
			case 2
			SetGlobalTags user_options params = {resting_whammy_position_device_2 = <rightx>}
			case 3
			SetGlobalTags user_options params = {resting_whammy_position_device_3 = <rightx>}
			case 4
			SetGlobalTags user_options params = {resting_whammy_position_device_4 = <rightx>}
			case 5
			SetGlobalTags user_options params = {resting_whammy_position_device_5 = <rightx>}
			case 6
			SetGlobalTags user_options params = {resting_whammy_position_device_6 = <rightx>}
		endswitch
		if (<device_num> = $player1_status.controller)
			get_resting_whammy_position controller = <device_num>
			change structurename = player1_status resting_whammy_position = <resting_whammy_position>
			
		else
			if (<device_num> = $player2_status.controller)
				get_resting_whammy_position controller = <device_num>
				change structurename = player2_status resting_whammy_position = <resting_whammy_position>
			endif
		endif
		change \{options_autosave_required = 1}
	endif
endscript
