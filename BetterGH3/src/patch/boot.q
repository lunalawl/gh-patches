script bootup_sequence 
	wait_for_legal_timer
	startrendering
	playmovieandwait \{movie = 'atvi'}
	playmovieandwait \{movie = 'ro_logo'}
	playmovieandwait \{movie = 'ns_logo'}
	playmovieandwait \{movie = 'intro'}
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = skip_bootup_sequence
			play_sound = 0
		}}
endscript
