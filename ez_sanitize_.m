function sanitisedStr = ez_sanitize_( inputStr )
  
%%% ??URL??????????????????????? ###
% --- http://www.ietf.org/rfc/rfc2396.txt ---
% uric = reserved | unreserved | escaped
% reserved = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" | "$" | ","
% unreserved = alphanum | mark
% mark = "-" | "_" | "." | "!" | "~" | "*" | "'" | "(" | ")"
% escaped = "%" hex hex

% return '' if($url =~ m|[^;/?:@&=+\$,A-Za-z0-9\-_.!~*'()%]|);

%expression = '[\^;/?:@&=+\$,\-_.!~*''()%]';
expression = '[\^;/?:@&=+\$,\-_!~*''()%]';
sanitisedStr = regexprep( inputStr, expression, ' ' );

return;

