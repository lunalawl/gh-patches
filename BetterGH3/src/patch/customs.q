script load_songqpak \{async = 0}
	if NOT (<song_name> = $current_song_qpak)
		unload_songqpak
		get_song_prefix Song = <song_name>
		is_song_downloaded song_checksum = <song_name>
		if (<Download> = 1)
			FormatText TextName = songqpak 'songs/%i_song.pak' I = <song_prefix>
		else
			FormatText TextName = songqpak 'songs/%i_song.pak' I = <song_prefix>
		endif
		Printf "Loading Song q pak : %i" I = <songqpak>
		if NOT LoadPakAsync pak_name = <songqpak> Heap = heap_song no_vram async = <async>
			DownloadContentLost
			return
		endif
		Change current_song_qpak = <song_name>
		if GotParam \{song_prefix}
			FormatText ChecksumName = song_setup '%s_setup' S = <song_prefix>
			if ScriptExists <song_setup>
				SpawnScriptNow <song_setup>
			endif
		endif
	endif
endscript

script unload_songqpak 
	if NOT ($current_song_qpak = NONE)
		get_song_prefix Song = ($current_song_qpak)
		is_song_downloaded song_checksum = ($current_song_qpak)
		if (<Download> = 1)
			FormatText TextName = songqpak 'songs/%i_song.pak' I = <song_prefix>
		else
			FormatText TextName = songqpak 'songs/%i_song.pak' I = <song_prefix>
		endif
		Printf "UnLoading Song q pak : %i" I = <songqpak>
		UnLoadPak <songqpak>
		Change \{current_song_qpak = NONE}
	endif
endscript

script is_song_downloaded \{song_checksum = schoolsout}
	if StructureContains Structure = ($download_songlist_props) <song_checksum>
		return \{Download = 1
				TRUE}
	else
		return \{Download = 0
			TRUE}
	endif
endscript

script Downloads_EnumContent 
	mark_unsafe_for_shutdown
	EnableDuplicateSymbolWarning \{off}
	if ($global_content_index_pak = 'none')
		filename = 'customs.pak'
		if NOT LoadPakAsync pak_name = <filename> heap = heap_downloads async = 1
			EnableDuplicateSymbolWarning
			mark_safe_for_shutdown
			DownloadContentLost
			return
		endif
		change global_content_index_pak = <filename>
	endif
	EnableDuplicateSymbolWarning
	mark_safe_for_shutdown
	Downloads_PostEnumContent
endscript

script Downloads_LoadLanguageContent 
	pakname = 'customs_text.pak'
	if French
		pakname = 'customs_text_f.pak'
	elseif Italian
		pakname = 'customs_text_i.pak'
	elseif German
		pakname = 'customs_text_g.pak'
	elseif Spanish
		pakname = 'customs_text_s.pak'
	endif
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
endscript

bootup_audio_calibrate_reminder_fs = {
	create = winport_create_audio_calibrate_reminder
	destroy = winport_destroy_audio_calibrate_reminder
	actions = [
		{
			action = continue
			flow_state = bootup_download_scan_fs
		}
	]
}

