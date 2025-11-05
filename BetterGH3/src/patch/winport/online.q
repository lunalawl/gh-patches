// Make account authorization screen not linger
// Provide more descriptive online messages
script create_winport_account_management_status_screen 
	printf \{"--- create_winport_account_management_status_screen"}
	create_menu_backdrop \{texture = online_background}
	z = 110
	createscreenelement \{type = containerelement
		parent = root_window
		id = accountstatuscontainer
		pos = (0.0, 0.0)}
	createscreenelement \{type = vscrollingmenu
		parent = accountstatuscontainer
		just = [
			center
			top
		]
		dims = (500.0, 150.0)
		pos = (640.0, 465.0)
		z_priority = 1}
	menu_id = <id>
	createscreenelement {
		type = vmenu
		parent = <menu_id>
		id = <vmenu_id>
		pos = (298.0, 0.0)
		just = [center top]
		internal_just = [center top]
		dims = (500.0, 150.0)
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
		]
	}
	vmenu_id = <id>
	change \{menu_focus_color = [
			180
			50
			50
			255
		]}
	change \{menu_unfocus_color = [
			0
			0
			0
			255
		]}
	create_pause_menu_frame \{parent = accountstatuscontainer
		z = 5}
	displaysprite \{parent = accountstatuscontainer
		tex = dialog_title_bg
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			right
			top
		]
		flip_v}
	displaysprite \{parent = accountstatuscontainer
		tex = dialog_title_bg
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			left
			top
		]}
	createscreenelement \{type = textelement
		parent = accountstatuscontainer
		font = fontgrid_title_gh3
		scale = 1.2
		rgba = [
			223
			223
			223
			250
		]
		text = $online_online
		just = [
			center
			top
		]
		z_priority = 10.0
		pos = (640.0, 182.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	createscreenelement {
		type = textblockelement
		parent = accountstatuscontainer
		id = statusmessage
		font = text_a4
		scale = 0.8
		rgba = [210 210 210 250]
		just = [center top]
		internal_just = [center top]
		internal_scale = <scale>
		z_priority = <z>
		pos = (640.0, 310.0)
		dims = (800.0, 320.0)
		line_spacing = 1.0
	}
	launchevent type = focus target = <vmenu_id>
	netsessionfunc \{func = executelogintask}
	begin
	netsessionfunc \{func = getnetworkstatus}
	switch (<currentnetworktask>)
		case $online_create_account
		switch (<currentnetworkstatus>)
			case $online_pending
			statustext = $online_requesting_account_creation
			case $online_done
			statustext = $online_account_created
			success = true
			case $online_failed
			statustext = $online_unable_create_account
			success = false
			default
			statustext = $online_internal_error
			success = false
		endswitch
		case $online_login_account
		switch (<currentnetworkstatus>)
			case $online_pending
			statustext = $online_authorizing_account
			case $online_done
			statustext = $online_account_authorized
			success = true
			case $online_failed
			statustext = $online_unable_authorize_account
			success = false
			default
			statustext = $online_internal_error
			success = false
		endswitch
		case $online_change_account
		switch (<currentnetworkstatus>)
			case $online_pending
			statustext = $online_requesting_password_change
			case $online_done
			statustext = $online_password_changed
			success = true
			case $online_failed
			statustext = $online_unable_change_password
			success = false
			default
			statustext = $online_internal_error
			success = false
		endswitch
		case $online_reset_account
		switch (<currentnetworkstatus>)
			case $online_pending
			statustext = $online_requesting_account_reset
			case $online_done
			statustext = $online_account_password_reset
			success = true
			case $online_failed
			statustext = $online_unable_reset_account
			success = false
			default
			statustext = $online_internal_error
			success = false
		endswitch
		case $online_delete_account
		switch (<currentnetworkstatus>)
			case $online_pending
			statustext = $online_requesting_account_deletion
			case $online_done
			statustext = $online_account_deleted
			success = true
			case $online_failed
			statustext = $online_unable_delete_account
			success = false
			default
			statustext = $online_internal_error
			success = false
		endswitch
		default
		printf "Unexpected state = %s" s = <currentnetworktask>
		statustext = $online_internal_error
		success = false
	endswitch
	setscreenelementprops id = statusmessage text = <statustext>
	fit_text_into_menu_item \{id = statusmessage
		max_width = 480}
	if gotparam \{success}
		break
	endif
	wait \{1
		frame}
	if NOT (screenelementexists id = accountstatuscontainer)
		return
	endif
	repeat
	if (<success> = false)
		netsessionfunc \{func = getautologinsetting}
		if (<autologinsetting> = autologinon && netsessionfunc func = hasexistinglogin)
			netsessionfunc \{func = setautologinsetting
				params = {
					autologinsetting = autologinprompt
				}}
		endif
		netsessionfunc \{func = getfailurecode}
		switch <failurecode>
			case 666
			statustext = $online_password_fields_match
			case 667
			statustext = $online_authorization_failed
			case 668
			statustext = $online_username_length
			case 669
			statustext = $online_password_length
			case 700
			statustext = $online_task_succeeded
			case 701
			statustext = $online_bad_authorization
			case 702
			statustext = $online_server_configuration
			case 703
			statustext = $online_invalid_title_id
			case 704
			statustext = $online_invalid_account
			case 705
			statustext = $online_illegal_authorization
			case 706
			statustext = $online_invalid_license
			case 707
			statustext = $online_username_exists
			case 708
			statustext = $online_invalid_username
			case 709
			statustext = $online_username_declined
			case 710
			statustext = $online_too_many_accounts
			case 711
			statustext = $online_migration_not_supported
			case 712
			statustext = $online_title_disabled
			case 713
			statustext = $online_account_expired
			case 714
			statustext = $online_account_locked
			case 715
			statustext = $online_authentication_error
			case 716
			statustext = $online_incorrect_password
		endswitch
		setscreenelementprops id = statusmessage text = <statustext>
		fit_text_into_menu_item \{id = statusmessage
			max_width = 480}
		displaysprite \{parent = accountstatuscontainer
			id = options_bg_1
			tex = dialog_bg
			pos = (640.0, 500.0)
			dims = (320.0, 64.0)
			z = 9
			just = [
				center
				botom
			]}
		displaysprite \{parent = accountstatuscontainer
			id = options_bg_2
			tex = dialog_bg
			pos = (640.0, 530.0)
			dims = (320.0, 64.0)
			z = 9
			just = [
				center
				top
			]
			flip_h}
		createscreenelement {
			type = containerelement
			parent = <vmenu_id>
			dims = (100.0, 50.0)
			event_handlers = [
				{focus net_warning_focus}
				{unfocus net_warning_unfocus}
				{pad_choose ui_flow_manager_respond_to_action params = {action = erroraction}}
				{pad_back ui_flow_manager_respond_to_action params = {action = erroraction}}
			]
		}
		container_id = <id>
		createscreenelement {
			type = textelement
			parent = <container_id>
			local_id = text
			font = fontgrid_title_gh3
			scale = 0.85
			rgba = ($menu_unfocus_color)
			text = $online_try_again
			just = [center top]
			z_priority = (<z> + 0.1)
		}
		fit_text_into_menu_item id = <id> max_width = 480
		getscreenelementdims id = <id>
		createscreenelement {
			type = spriteelement
			parent = <container_id>
			local_id = bookend_left
			texture = dialog_highlight
			alpha = 0.0
			just = [right center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
			flip_v
		}
		createscreenelement {
			type = spriteelement
			parent = <container_id>
			local_id = bookend_right
			texture = dialog_highlight
			alpha = 0.0
			just = [left center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
		}
		clean_up_user_control_helpers
		add_user_control_helper \{text = $buttons_select
			button = green
			z = 100}
		add_user_control_helper \{text = $buttons_back
			button = red
			z = 100}
		launchevent type = focus target = <vmenu_id>
		return
	endif
	ui_flow_manager_respond_to_action \{action = successaction}
	netsessionfunc \{func = stats_init}
endscript

script create_winport_connection_status_screen 
	printf \{"--- create_winport_connection_status_screen"}
	create_menu_backdrop \{texture = Online_Background}
	z = 110
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = connectionStatusContainer
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = connectionStatusContainer
		just = [
			center
			top
		]
		dims = (500.0, 150.0)
		pos = (640.0, 465.0)
		z_priority = 1}
	menu_id = <id>
	CreateScreenElement {
		type = VMenu
		parent = <menu_id>
		pos = (298.0, 0.0)
		just = [center top]
		internal_just = [center top]
		dims = (500.0, 150.0)
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back cancel_winport_connection_status_screen}
		]
	}
	vmenu_id = <id>
	change \{menu_focus_color = [
			180
			50
			50
			255
		]}
	change \{menu_unfocus_color = [
			0
			0
			0
			255
		]}
	create_pause_menu_frame \{parent = connectionStatusContainer
		z = 5}
	displaySprite \{parent = connectionStatusContainer
		tex = Dialog_Title_BG
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			right
			top
		]
		flip_v}
	displaySprite \{parent = connectionStatusContainer
		tex = Dialog_Title_BG
		dims = (224.0, 224.0)
		z = 9
		pos = (640.0, 100.0)
		just = [
			left
			top
		]}
	CreateScreenElement \{type = TextElement
		parent = connectionStatusContainer
		font = fontgrid_title_gh3
		scale = 1.2
		rgba = [
			223
			223
			223
			250
		]
		text = $online_online
		just = [
			center
			top
		]
		z_priority = 10.0
		pos = (640.0, 182.0)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	CreateScreenElement {
		type = TextBlockElement
		parent = connectionStatusContainer
		id = statusMessage
		font = text_a4
		scale = 0.8
		rgba = [210 210 210 250]
		just = [center top]
		internal_just = [center top]
		internal_scale = <scale>
		z_priority = <z>
		pos = (640.0, 310.0)
		dims = (800.0, 320.0)
		line_spacing = 1.0
	}
	if NOT (NetSessionFunc func = IsConnected)
		add_user_control_helper \{text = $online_cancel
			button = red
			z = 100}
		LaunchEvent type = focus target = <vmenu_id>
		NetSessionFunc \{func = onlinesignin}
		begin
		NetSessionFunc \{func = GetNetworkStatus}
		switch (<CurrentNetworkTask>)
			case $online_start_network
			switch (<CurrentNetworkStatus>)
				case $online_pending
				statusText = $online_connecting_network
				case $online_done
				statusText = $online_connected_network
				case $online_failed
				statusText = $online_unable_connect_internet
				success = false
				default
				statusText = $online_internal_error
				success = false
			endswitch
			case $online_check_dns
			switch (<CurrentNetworkStatus>)
				case $online_pending
				statusText = $online_connecting_game_servers
				case $online_done
				statusText = $online_connected_game_servers
				success = true
				case $online_failed
				statusText = $online_unable_connect_servers
				success = false
				default
				statusText = $online_internal_error
				success = false
			endswitch
			default
			statusText = $online_internal_error
			success = false
		endswitch
		SetScreenElementProps id = statusMessage text = <statusText>
		fit_text_into_menu_item \{id = statusMessage
			max_width = 480}
		if GotParam \{success}
			clean_up_user_control_helpers
			if (<success> = false)
				add_user_control_helper \{text = $buttons_back
					button = red
					z = 100}
				return
			endif
			break
		endif
		Wait \{1
			frame}
		if NOT (ScreenElementExists id = connectionStatusContainer)
			return
		endif
		repeat
	endif
	if NOT (NetSessionFunc func = HasExistingLogin)
		SetScreenElementProps \{id = statusMessage
			text = $online_create_account_guide}
		fit_text_into_menu_item \{id = statusMessage
			max_width = 480}
		displaySprite \{parent = connectionStatusContainer
			id = options_bg_1
			tex = dialog_bg
			pos = (640.0, 500.0)
			dims = (320.0, 64.0)
			z = 9
			just = [
				center
				botom
			]}
		displaySprite \{parent = connectionStatusContainer
			id = options_bg_2
			tex = dialog_bg
			pos = (640.0, 530.0)
			dims = (320.0, 64.0)
			z = 9
			just = [
				center
				top
			]
			flip_h}
		CreateScreenElement {
			type = ContainerElement
			parent = <vmenu_id>
			dims = (100.0, 50.0)
			event_handlers = [
				{focus net_warning_focus}
				{unfocus net_warning_unfocus}
				{pad_choose start_winport_account_login_screen}
				{pad_back cancel_winport_connection_status_screen}
			]
		}
		container_id = <id>
		CreateScreenElement {
			type = TextElement
			parent = <container_id>
			local_id = text
			font = fontgrid_title_gh3
			scale = 0.85
			rgba = ($menu_unfocus_color)
			text = $online_log_in
			just = [center top]
			z_priority = (<z> + 0.1)
		}
		fit_text_into_menu_item id = <id> max_width = 200
		GetScreenElementDims id = <id>
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			local_id = bookend_left
			texture = Dialog_Highlight
			alpha = 0.0
			just = [right center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
			flip_v
		}
		CreateScreenElement {
			type = SpriteElement
			parent = <container_id>
			local_id = bookend_right
			texture = Dialog_Highlight
			alpha = 0.0
			just = [left center]
			pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
			z_priority = (<z> + 0.1)
			scale = (1.0, 1.0)
		}
		add_user_control_helper \{text = $buttons_select
			button = green
			z = 100}
		add_user_control_helper \{text = $buttons_back
			button = red
			z = 100}
		add_user_control_helper \{text = $buttons_up_down
			button = strumbar
			z = 100}
		LaunchEvent type = focus target = <vmenu_id>
		return
	endif
	if NOT (NetSessionFunc func = IsLoggedIn)
		ui_flow_manager_respond_to_action \{action = account_login}
	endif
	ui_flow_manager_respond_to_action \{action = goto_online_menu}
endscript