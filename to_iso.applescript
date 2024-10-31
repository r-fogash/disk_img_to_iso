set input_file_alias to choose file with prompt "Please select a disk image to convert:"
set input_file_path to POSIX path of input_file_alias
set output_file_path to quoted form of (replaceExtension(input_file_path, "iso"))
set shell_command to "hdiutil makehybrid -iso -joliet -o " & output_file_path & " " & (quoted form of input_file_path)

do shell script shell_command



to replaceExtension(path, new_extension)
	set original_string_delimiter to text item delimiters
	
	set text item delimiters to "/"
	set path_components to text items of path
	
	if length of path_components ≤ 1 then
		return path
	end if
	
	set last_path_component to item -1 of path_components
	set processed_last_path_component to without_extension(last_path_component)
	set processed_last_path_component to processed_last_path_component & "." & new_extension
	
	set item -1 of path_components to processed_last_path_component
	set processed_path to path_components as text
	set text item delimiters to original_string_delimiter
	return processed_path
end replaceExtension

to without_extension(path_arg)
	if path_arg contains "." then
		set file_name to path_arg
		set old_delims to text item delimiters
		set text item delimiters to "."
		set file_name_items to text items -2 thru 1 of path_arg
		set result_path to file_name_items as text
		set text item delimiters to old_delims
		return result_path
	end if
	return path_arg
end without_extension
