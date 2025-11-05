GH3_Download_Songs = {
	prefix = 'download'
	num_tiers = 1
	tier1 = {
		title = "Downloaded songs"
		songs = [
		]
		defaultunlocked = 4
		level = load_z_artdeco
	}
}

script scan_globaltag_downloads 
	printstruct ($GH3_Download_Songs)
	setup_setlisttags \{SetList_Songs = GH3_Download_Songs
		force = 1}
	setup_songtags
	setup_generalvenuetags
	setup_characterguitar_tags
endscript
global_content_index_pak = 'none'
global_content_index_pak_language = 'none'

script Downloads_EnumContent 
	mark_unsafe_for_shutdown
	if EnumContentFiles \{download
			dofiles}
		begin
		if EnumContentFilesFinished
			break
		else
			printf \{"Waiting for Download Contend Enumeration"}
			Wait \{1
				gameframe}
		endif
		repeat
	endif
	mark_safe_for_shutdown
	if IsEnumContentFilesDamaged
		destroy_popup_warning_menu
		create_popup_warning_menu \{create_popup_warning_menu
			textblock = {
				text = "A content package appears damaged or unreadable. Please re-download the content package."
				Wait
				3
				seconds
			}
			menu_pos = (640.0, 490.0)
			dialog_dims = (288.0, 64.0)
			options = [
				{
					func = {
						Downloads_Enumcontentfiles_Continue
					}
					text = "CONTINUE"
					scale = (1.0, 1.0)
				}
			]}
		change \{Downloads_Enumcontentfiles_Continue_Flag = 0}
		begin
		if ($Downloads_Enumcontentfiles_Continue_Flag = 1)
			break
		endif
		Wait \{1
			gameframe}
		repeat
	endif
	if GetLatestContentIndexFile
		printf \{"Found latest content index file:"}
		printstruct <...>
		mark_unsafe_for_shutdown
		EnableDuplicateSymbolWarning \{off}
		if NOT LoadPakAsync pak_name = <filename> heap = heap_downloads async = 1
			EnableDuplicateSymbolWarning
			mark_safe_for_shutdown
			DownloadContentLost
			return
		endif
		EnableDuplicateSymbolWarning
		change global_content_index_pak = <filename>
		mark_safe_for_shutdown
		Downloads_LoadLanguageContent <...>
	else
		printf \{"Found no latest content index file"}
	endif
	if ScriptExists \{Downloads_Startup}
		Downloads_Startup
	endif
	Downloads_PostEnumContent
endscript

script destroy_downloads_EnumContent 
	KillSpawnedScript \{name = Downloads_EnumContent}
	Downloads_CloseContentFolder \{force = 1}
endscript

script Downloads_LoadLanguageContent 
	FormatText TextName = pakname '%s_text.pak' s = <stem>
	if English
		FormatText TextName = pakname '%s_text.pak' s = <stem>
	elseif French
		FormatText TextName = pakname '%s_text_f.pak' s = <stem>
	elseif Italian
		FormatText TextName = pakname '%s_text_i.pak' s = <stem>
	elseif German
		FormatText TextName = pakname '%s_text_g.pak' s = <stem>
	elseif Spanish
		FormatText TextName = pakname '%s_text_s.pak' s = <stem>
	endif
	GetContentFolderIndexFromFile <pakname>
	if (<device> = content)
		printf "Download Language Content found %s" s = <pakname>
		mark_unsafe_for_shutdown
		EnableDuplicateSymbolWarning \{off}
		if NOT LoadPakAsync pak_name = <pakname> heap = heap_downloads async = 1
			EnableDuplicateSymbolWarning
			mark_safe_for_shutdown
			DownloadContentLost
			return
		endif
		EnableDuplicateSymbolWarning
		change global_content_index_pak_language = <pakname>
		mark_safe_for_shutdown
	else
		printf "Download Language Content no found %s" s = <pakname>
	endif
endscript

script Downloads_PostEnumContent 
	Download_RecreateZones
	scan_globaltag_downloads
endscript
Downloads_Enumcontentfiles_Continue_Flag = 0

script Downloads_Enumcontentfiles_Continue 
	change \{Downloads_Enumcontentfiles_Continue_Flag = 1}
endscript

script Downloads_UnloadContent 
	KillSpawnedScript \{name = Downloads_OpenContentFolder}
	change \{downloadcontentfolder_lock = 0}
	if NOT ($global_content_index_pak = 'none')
		UnloadPak ($global_content_index_pak)
		change \{global_content_index_pak = 'none'}
	endif
	if NOT ($global_content_index_pak_language = 'none')
		UnloadPak ($global_content_index_pak_language)
		change \{global_content_index_pak_language = 'none'}
	endif
endscript

script Download_RecreateZones 
	mark_unsafe_for_shutdown
	printf \{"Loading Zone"}
	SetPakManCurrentBlock \{map = zones
		pak = none}
	DestroyPakManMap \{map = zones}
	MemPushContext \{heap_zones}
	CreatePakManMap \{map = zones
		links = GH3Zones
		folder = 'zones/'
		uselinkslots}
	MemPopContext
	SetPakManCurrentBlock \{map = zones
		pak = z_soundcheck}
	mark_safe_for_shutdown
endscript
downloadcontentfolder_lock = 0
downloadcontentfolder_index = -1
downloadcontentfolder_count = 0

script Downloads_OpenContentFolder 
	mark_unsafe_for_shutdown
	begin
	if ($downloadcontentfolder_lock = 0)
		break
	endif
	if ($downloadcontentfolder_index = <content_index>)
		change downloadcontentfolder_count = ($downloadcontentfolder_count + 1)
		mark_safe_for_shutdown
		return \{true}
	endif
	Wait \{1
		gameframe}
	repeat
	change \{downloadcontentfolder_lock = 1}
	if NOT OpenContentFolder content_index = <content_index>
		mark_safe_for_shutdown
		return \{false}
	endif
	begin
	GetContentFolderState
	if (<contentfolderstate> = failed)
		change \{downloadcontentfolder_lock = 0}
		mark_safe_for_shutdown
		return \{false}
	endif
	if (<contentfolderstate> = opened)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	change downloadcontentfolder_count = ($downloadcontentfolder_count + 1)
	change downloadcontentfolder_index = <content_index>
	mark_safe_for_shutdown
	return \{true}
endscript

script Downloads_CloseContentFolder \{force = 0}
	mark_unsafe_for_shutdown
	if (<force> = 1)
		if ($downloadcontentfolder_index = -1)
			mark_safe_for_shutdown
			return
		endif
	endif
	if (<force> = 1)
		change \{downloadcontentfolder_count = 0}
	else
		change downloadcontentfolder_count = ($downloadcontentfolder_count - 1)
		if ($downloadcontentfolder_count > 0)
			change \{downloadcontentfolder_count = 0}
			mark_safe_for_shutdown
			return \{true}
		endif
	endif
	if (<force> = 1)
		content_index = ($downloadcontentfolder_index)
	else
		change \{downloadcontentfolder_index = -1}
	endif
	if NOT CloseContentFolder content_index = <content_index>
		change \{downloadcontentfolder_lock = 0}
		mark_safe_for_shutdown
		return \{false}
	endif
	begin
	GetContentFolderState
	if (<contentfolderstate> = free)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	change \{downloadcontentfolder_lock = 0}
	mark_safe_for_shutdown
	return \{true}
endscript

script create_download_scan_menu 
	change \{menu_flow_play_sound = 0}
	if ($downloadcontent_enabled = 0)
		ui_flow_manager_respond_to_action \{action = continue}
		return
	endif
	GetPlatform
	switch <platform>
		case ps3
		create_popup_warning_menu \{textblock = {
				text = "Checking the HDD. Do not switch off your system."
			}}
		Wait \{1
			gameframes}
		case xenon
		create_popup_warning_menu \{textblock = {
				text = "Checking for downloadable content."
			}}
	endswitch
	Downloads_EnumContent
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script destroy_download_scan_menu 
	destroy_popup_warning_menu
endscript

script is_musician_profile_downloaded 
	GetArraySize \{$Musician_Profiles}
	if (<index> < <array_size>)
		return \{download = 0
			true}
	else
		profile_struct = ($download_musician_profiles [(<index> - <array_size>)])
		get_pak_filename desc_id = (<profile_struct>.musician_body.desc_id) type = Body
		GetContentFolderIndexFromFile <pak_name>
		if (<device> = content)
			return \{download = 1
				true}
		else
			return \{download = 1
				false}
		endif
	endif
endscript

script is_musician_instrument_downloaded 
	GetArraySize \{$musician_instrument}
	if (<index> < <array_size>)
		return \{download = 0
			true}
	else
		profile_struct = ($download_musician_instrument [(<index> - <array_size>)])
		get_pak_filename desc_id = (<profile_struct>.desc_id) type = instrument
		GetContentFolderIndexFromFile <pak_name>
		if (<device> = content)
			return \{download = 1
				true}
		else
			return \{download = 1
				false}
		endif
	endif
endscript

script find_instrument_index 
	get_musician_instrument_size
	index = 0
	begin
	get_musician_instrument_struct index = <index>
	if (<info_struct>.desc_id = <desc_id>)
		return index = <index> true
	endif
	index = (<index> + 1)
	repeat <array_size>
	return \{false}
endscript

script store_select_downloads 
	NetSessionFunc \{func = ShowMarketPlaceUI}
	wait_for_blade_complete
	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	destroy_band
	Downloads_UnloadContent
endscript

script fmod_diskejected_event 
	printf \{"fmod_diskejected_event"}
	DownloadContentLost
endscript

script DownloadContentLost 
	change \{is_changing_levels = 0}
	printscriptinfo \{"DownloadContentLost"}
	spawnscriptnow \{noqbid
		DownloadContentLost_Spawned}
	KillSpawnedScript \{name = DownloadContentLost}
endscript

script DownloadContentLost_Spawned 
	if ($respond_to_signin_changed = 0)
		return
	endif
	change \{respond_to_signin_changed = 0}
	printf \{"DownloadContentLost_Spawned"}
	disable_pause
	stoprendering
	shutdown_game_for_signin_change
	LaunchEvent \{type = unfocus
		target = root_window}
	create_downloadcontentlost_menu
	startrendering
	printf \{"DownloadContentLost"}
endscript

script create_downloadcontentlost_menu 
	destroy_popup_warning_menu
	create_popup_warning_menu \{title = "CONTENT CHANGED"
		title_props = {
			scale = 1.0
		}
		textblock = {
			text = "Download Content has changed. As a result, the game has restarted."
			pos = (640.0, 380.0)
		}
		menu_pos = (640.0, 490.0)
		dialog_dims = (288.0, 64.0)
		options = [
			{
				func = {
					downloadcontentlost_reboot
				}
				text = "CONTINUE"
				scale = (1.0, 1.0)
			}
		]}
endscript

script downloadcontentlost_reboot 
	printf \{"downloadcontentlost_reboot"}
	destroy_downloadcontentlost_menu
	enable_pause
	Wait \{5
		gameframes}
	start_flow_manager \{flow_state = bootup_press_any_button_fs}
	printf \{"downloadcontentlost_reboot end"}
endscript

script destroy_downloadcontentlost_menu 
	destroy_popup_warning_menu
endscript

script recreate_downloadcontentlost_menu 
	destroy_downloadcontentlost_menu
	create_downloadcontentlost_menu
endscript
net_checksum_packet = [
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
	none
]
num_net_checksum_packet = 0
total_num_net_checksum_packet = 0
net_match_available_items_request_finished = 0
net_match_send_available_items_dirty = 0

script net_match_send_available_items 
	printf \{"net_match_send_available_items"}
	disable_pause
	if ($net_match_send_available_items_dirty = 0)
		return
	endif
	change \{net_match_send_available_items_dirty = 0}
	if NOT IsHost
		destroy_popup_warning_menu
		create_popup_warning_menu \{title = "ONLINE"
			title_props = {
				scale = 1.0
			}
			textblock = {
				text = "Sending Profile Information. Please Wait."
				pos = (640.0, 380.0)
			}}
	endif
	net_match_clear_available_items
	change \{net_match_available_items_request_finished = 0}
	SendStructure \{callback = net_match_available_items_send
		data_to_send = {
			none
		}}
	wait_for_net_match_available_items
	destroy_popup_warning_menu
	printf \{"net_match_send_available_items end"}
endscript

script net_match_clear_available_items 
	get_songlist_size
	song_count = 0
	begin
	get_songlist_checksum index = <song_count>
	SetGlobalTags <song_checksum> params = {available_on_other_client = 0}
	song_count = (<song_count> + 1)
	repeat <array_size>
	printf "Local total songs = %i" i = <array_size>
	guitar_array = ($Bonus_Guitars)
	store_add_secret_guitars_and_basses guitar_array = (<guitar_array>)
	GetArraySize <guitar_array>
	index = 0
	begin
	guitar_id = (<guitar_array> [<index>].id)
	SetGlobalTags <guitar_id> params = {unlocked_on_other_client = 0
		available_on_other_client = 0}
	<index> = (<index> + 1)
	repeat <array_size>
	guitar_array = ($Bonus_Guitar_Finishes)
	GetArraySize <guitar_array>
	index = 0
	begin
	guitar_id = (<guitar_array> [<index>].id)
	SetGlobalTags <guitar_id> params = {unlocked_on_other_client = 0
		available_on_other_client = 0}
	<index> = (<index> + 1)
	repeat <array_size>
	character_array = ($Secret_Characters)
	GetArraySize <character_array>
	index = 0
	begin
	character_id = (<character_array> [<index>].id)
	SetGlobalTags <character_id> params = {unlocked_on_other_client = 0}
	<index> = (<index> + 1)
	repeat <array_size>
	get_musician_profile_size
	index = 0
	begin
	get_musician_profile_struct index = <index>
	character_id = (<profile_struct>.musician_body.desc_id)
	SetGlobalTags <character_id> params = {available_on_other_client = 0}
	<index> = (<index> + 1)
	repeat <array_size>
	character_array = ($Bonus_Outfits)
	GetArraySize <character_array>
	index = 0
	begin
	character_id = (<character_array> [<index>].id)
	SetGlobalTags <character_id> params = {unlocked_on_other_client = 0
		available_on_other_client = 0}
	<index> = (<index> + 1)
	repeat <array_size>
	character_array = ($Bonus_Styles)
	GetArraySize <character_array>
	index = 0
	begin
	character_id = (<character_array> [<index>].id)
	SetGlobalTags <character_id> params = {unlocked_on_other_client = 0
		available_on_other_client = 0}
	<index> = (<index> + 1)
	repeat <array_size>
	return \{true}
endscript

script wait_for_net_match_available_items 
	begin
	if ($net_match_available_items_request_finished = 1)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	change \{net_match_available_items_request_finished = 0}
endscript

script net_match_available_items_send 
	printf \{"net_match_available_items_send"}
	net_match_init_items
	get_songlist_size
	song_count = 0
	begin
	get_songlist_checksum index = <song_count>
	if is_song_downloaded song_checksum = <song_checksum>
		net_match_add_item <...> item = <song_checksum>
	endif
	song_count = (<song_count> + 1)
	repeat <array_size>
	net_match_send_items <...>
	net_match_init_items
	guitar_array = ($Bonus_Guitars)
	store_add_secret_guitars_and_basses guitar_array = (<guitar_array>)
	GetArraySize <guitar_array>
	index = 0
	begin
	guitar_id = (<guitar_array> [<index>].id)
	GetGlobalTags <guitar_id>
	if (<unlocked> = 1)
		net_match_add_item <...> item = <guitar_id>
	endif
	get_instrument_name_and_index id = <guitar_id>
	<index> = (<index> + 1)
	repeat <array_size>
	net_match_send_items <...> for_unlock = 1
	net_match_init_items
	guitar_array = ($Bonus_Guitar_Finishes)
	GetArraySize <guitar_array>
	index = 0
	begin
	guitar_id = (<guitar_array> [<index>].id)
	GetGlobalTags <guitar_id>
	if (<unlocked> = 1)
		net_match_add_item <...> item = <guitar_id>
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	net_match_send_items <...> for_unlock = 1
	net_match_init_items
	character_array = ($Secret_Characters)
	GetArraySize <character_array>
	index = 0
	begin
	character_id = (<character_array> [<index>].id)
	GetGlobalTags <character_id>
	if (<unlocked> = 1)
		net_match_add_item <...> item = <character_id>
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	net_match_send_items <...> for_unlock = 1
	character_array = ($Bonus_Outfits)
	GetArraySize <character_array>
	index = 0
	begin
	character_id = (<character_array> [<index>].id)
	GetGlobalTags <character_id>
	if (<unlocked> = 1)
		net_match_add_item <...> item = <character_id>
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	net_match_send_items <...> for_unlock = 1
	character_array = ($Bonus_Styles)
	GetArraySize <character_array>
	index = 0
	begin
	character_id = (<character_array> [<index>].id)
	GetGlobalTags <character_id>
	if (<unlocked> = 1)
		net_match_add_item <...> item = <character_id>
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	net_match_send_items <...> for_unlock = 1
	net_match_init_items \{type = Download_Guitars}
	if GlobalExists \{name = Download_Guitars}
		guitar_array = ($Download_Guitars)
		GetArraySize <guitar_array>
		index2 = 0
		begin
		find_instrument_index desc_id = (<guitar_array> [<index2>])
		get_musician_instrument_struct index = <index>
		if is_musician_instrument_downloaded index = <index>
			if (<download> = 1)
				net_match_add_item <...> item = (<info_struct>.desc_id)
			endif
		endif
		<index2> = (<index2> + 1)
		repeat <array_size>
	endif
	net_match_send_items <...>
	net_match_init_items \{type = Download_Basses}
	if GlobalExists \{name = Download_Basses}
		guitar_array = ($Download_Basses)
		GetArraySize <guitar_array>
		index2 = 0
		begin
		find_instrument_index desc_id = (<guitar_array> [<index2>])
		get_musician_instrument_struct index = <index>
		if is_musician_instrument_downloaded index = <index>
			if (<download> = 1)
				net_match_add_item <...> item = (<info_struct>.desc_id)
			endif
		endif
		<index2> = (<index2> + 1)
		repeat <array_size>
	endif
	net_match_send_items <...>
	net_match_init_items \{type = download_characters}
	get_musician_profile_size
	index = 0
	begin
	get_musician_profile_struct index = <index>
	if is_musician_profile_downloaded index = <index>
		if (<download> = 1)
			net_match_add_item <...> item = (<profile_struct>.musician_body.desc_id)
		endif
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	net_match_send_items <...>
	Wait \{1
		gameframe}
	net_match_init_items \{final = 1}
	net_match_send_items <...>
	printf \{"net_match_available_items_send end"}
endscript

script net_match_init_items \{final = 0
		type = generic}
	change \{num_net_checksum_packet = 0}
	change \{total_num_net_checksum_packet = 0}
	return message_struct = {final = <final> type = <type>}
endscript

script net_match_add_item \{message_struct = {
			final = 0
		}}
	SetArrayElement ArrayName = net_checksum_packet GlobalArray index = ($num_net_checksum_packet) newvalue = <item>
	change num_net_checksum_packet = ($num_net_checksum_packet + 1)
	change total_num_net_checksum_packet = ($total_num_net_checksum_packet + 1)
	if ($num_net_checksum_packet = 20)
		message_struct = {message_link = <message_struct> net_items = ($net_checksum_packet) num_valid = 20}
		change \{num_net_checksum_packet = 0}
	endif
	return message_struct = <message_struct>
endscript

script net_match_send_items \{for_unlock = 0
		additional_info = {
		}}
	message_struct = {message_link = <message_struct> net_items = ($net_checksum_packet) num_valid = ($num_net_checksum_packet)}
	SendStructure callback = net_match_download_items_send_callback data_to_send = {message_struct = <message_struct> for_unlock = <for_unlock> total_items = ($total_num_net_checksum_packet) additional_info = <additional_info>}
endscript
download_characters_on_other_client = 0
download_basses_on_other_client = 0
download_guitars_on_other_client = 0

script net_match_download_items_send_callback 
	printf \{"net_match_download_items_send_callback"}
	printstruct <...>
	begin
	if NOT StructureContains Structure = <message_struct> num_valid
		if (<message_struct>.final = 1)
			change \{net_match_available_items_request_finished = 1}
		endif
		break
	endif
	index = 0
	if ((<message_struct>.num_valid) > 0)
		begin
		if (<for_unlock> = 1)
			SetGlobalTags (<message_struct>.net_items [<index>]) params = {unlocked_on_other_client = 1}
		else
			SetGlobalTags (<message_struct>.net_items [<index>]) params = {available_on_other_client = 1}
		endif
		index = (<index> + 1)
		repeat (<message_struct>.num_valid)
	endif
	message_struct = (<message_struct>.message_link)
	repeat
	if (<message_struct>.type = download_characters)
		change download_characters_on_other_client = <total_items>
	endif
	if (<message_struct>.type = Download_Guitars)
		change download_guitars_on_other_client = <total_items>
	endif
	if (<message_struct>.type = Download_Basses)
		change download_basses_on_other_client = <total_items>
	endif
endscript
