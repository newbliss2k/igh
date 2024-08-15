function scr_writer_redline_check() {
	
	timer_redline=0
	var _current_char_safe=current_char
	current_char=0
	while !(current_char_str()="") {
		scr_writer_format(1)
		current_char++
	}
	current_char=_current_char_safe
	if timer_redline<30 timer_redline=30
}

function scr_writer_format(_safe=0){
	
	draw_set_font(font_dialogue)
	
	if (current_char_str()=" ") and (_safe=0) {
		
		var _offset = 1
		var _test_string = ""
		while !(current_char_str(_offset)=" " or current_char_str(_offset)="") {
			
			while current_char_str(_offset)="/" or current_char_str(_offset)="<" switch current_char_str(_offset) {
				case "/":	_offset+=2
							break
				
				case "<":	while !(current_char_str(_offset)=">") _offset++
			}
			
			if !(current_char_str(_offset)=" " or current_char_str(_offset)="") {
				_test_string+=current_char_str(_offset)
				_offset++
			}
			
		}
		
		if (x+string_width(_test_string))>max_line_width {
			//log_push(_test_string)
			//log_push(string(string_width(_test_string)))
			x=text_x
			y+=new_line_offset
			current_char++
		}
		
	}
	if current_char_str()="/" or current_char_str()="<"
	while current_char_str()="/" or current_char_str()="<" switch current_char_str() {
		case "/": switch current_char_str(1){
				
						// /n - оператор для новой линии.
						case "n":	if _safe=0 {
										x=text_x
										y+=new_line_offset
									}
									current_char+=2
									break;
				
						// /c - ничего не делает, но вы можете придумать назначение этому оператору!
						case "c":	break;
				
					} break;
			
		case "<":
			var _keyword=get_keyword()
			if string_ends_with(_keyword,"/") switch _keyword {
					
				case "color/":	if _safe=0 {
									c1=c_white
									c2=c_white
									c3=c_white
									c4=c_white;
								}
								break;
					
			} else switch (string_split(_keyword,"=")[0]) {
					
				case "timer":	if _safe=0 {
									timer=real(string_split(_keyword,"=")[1]);
									
								}
								else timer_redline+=0.5*real(string_split(_keyword,"=")[1]);
									
								break;
					
				case "c4":		if _safe=0 {
									c1=real(string_split(_keyword,"=")[1]);
									c2=real(string_split(_keyword,"=")[2]);
									c3=real(string_split(_keyword,"=")[3]);
									c4=real(string_split(_keyword,"=")[4]);
								}
								break;
									
				case "color":	if _safe=0 {
									c1=real(string_split(_keyword,"=")[1]);
									c2=real(string_split(_keyword,"=")[1]);
									c3=real(string_split(_keyword,"=")[1]);
									c4=real(string_split(_keyword,"=")[1]); break;
								}
				case "tag2":	break;
					
			} break;
	}
	
		if _safe=1 timer_redline++
	
}