cheat_largegems = -1

script setup_user_option_tags
	if iswinport
		setglobaltags \{user_options
			params = {
				guitar_volume = 11
				band_volume = 11
				sfx_volume = 11
				lefty_flip_p1 = 0
				lefty_flip_p2 = 0
				lag_calibration = 0.0
				lag_audio = 0.0
				lag_video = 0.0
				autosave = 1
				resting_whammy_position_device_0 = -0.76
				resting_whammy_position_device_1 = -0.76
				resting_whammy_position_device_2 = -0.76
				resting_whammy_position_device_3 = -0.76
				resting_whammy_position_device_4 = -0.76
				resting_whammy_position_device_5 = -0.76
				resting_whammy_position_device_6 = -0.76
				star_power_position_device_0 = -1.0
				star_power_position_device_1 = -1.0
				star_power_position_device_2 = -1.0
				star_power_position_device_3 = -1.0
				star_power_position_device_4 = -1.0
				star_power_position_device_5 = -1.0
				star_power_position_device_6 = -1.0
				gamma_brightness = 5
				online_game_mode = 0
				online_difficulty = 0
				online_num_songs = 0
				online_tie_breaker = 0
				online_highway = 0
				unlock_cheat_airguitar = 0
				unlock_cheat_performancemode = 0
				unlock_cheat_hyperspeed = 0
				unlock_cheat_nofail = 0
				unlock_cheat_easyexpert = 0
				unlock_cheat_precisionmode = 0
				unlock_cheat_largegems = 0
				unlock_cheat_bretmichaels = 0
			}}
	else
		setglobaltags \{user_options
			params = {
				guitar_volume = 11
				band_volume = 11
				sfx_volume = 11
				lefty_flip_p1 = 0
				lefty_flip_p2 = 0
				lag_calibration = 0.0
				autosave = 1
				resting_whammy_position_device_0 = -0.76
				resting_whammy_position_device_1 = -0.76
				resting_whammy_position_device_2 = -0.76
				resting_whammy_position_device_3 = -0.76
				resting_whammy_position_device_4 = -0.76
				resting_whammy_position_device_5 = -0.76
				resting_whammy_position_device_6 = -0.76
				star_power_position_device_0 = -1.0
				star_power_position_device_1 = -1.0
				star_power_position_device_2 = -1.0
				star_power_position_device_3 = -1.0
				star_power_position_device_4 = -1.0
				star_power_position_device_5 = -1.0
				star_power_position_device_6 = -1.0
				gamma_brightness = 5
				online_game_mode = 0
				online_difficulty = 0
				online_num_songs = 0
				online_tie_breaker = 0
				online_highway = 0
				unlock_cheat_airguitar = 0
				unlock_cheat_performancemode = 0
				unlock_cheat_hyperspeed = 0
				unlock_cheat_nofail = 0
				unlock_cheat_easyexpert = 0
				unlock_cheat_precisionmode = 0
				unlock_cheat_largegems = 0
				unlock_cheat_bretmichaels = 0
			}}
	endif
endscript

script restore_options_from_global_tags 
	getglobaltags \{user_options}
	if (<lefty_flip_p1>)
		change \{pad_event_up_inversion = true}
	else
		change \{pad_event_up_inversion = false}
	endif

	// Restore saved hyperspeed setting
	Change GlobalName = Cheat_HyperSpeed NewValue = <Cheat_HyperSpeed>

	// Disable original "Audio Lag" setting on PC
	if iswinport
		winportsetsongskew value = 0
	endif

endscript
