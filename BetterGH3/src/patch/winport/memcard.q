// Fix loading issues on PC
script memcard_check_for_existing_save
	if ($memcard_using_new_save_system = 0)
		if isps3
			return \{found = 0}
		endif
		memcard_choose_storage_device
		getmemcarddirectorylisting \{filetype = progress}
		if (<totalthps4filesoncard> = 1)
			printf \{"Found save file"}
			return \{found = 1
				corrupt = 0}
		endif
	else
		memcard_enum_folders
		mc_waitasyncopsfinished
		memcard_check_for_card
		if mc_folderexists \{foldername = $memcard_content_name}
			mc_setactivefolder \{foldername = $memcard_content_name}
			mc_loadtocinactivefolder
			if (<result> = false)
				if iswinport
					memcard_sequence_begin_bootup
				else
					return \{found = 1
						corrupt = 1}
				endif
			endif
			if memcardfileexists \{filename = $memcard_file_name
					filetype = progress}
				return \{found = 1
					corrupt = 0}
			else
				return \{found = 1
					corrupt = 1}
			endif
		endif
	endif
	return \{found = 0
		corrupt = 0}
endscript
