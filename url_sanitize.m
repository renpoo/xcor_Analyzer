function ez_url_sanitize( url )
  
%%% ??URL??????????????????????? ###
% --- http://www.ietf.org/rfc/rfc2396.txt ---
% uric = reserved | unreserved | escaped
% reserved = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" | "$" | ","
% unreserved = alphanum | mark
% mark = "-" | "_" | "." | "!" | "~" | "*" | "'" | "(" | ")"
% escaped = "%" hex hex

% return '' if($url =~ m|[^;/?:@&=+\$,A-Za-z0-9\-_.!~*'()%]|);

expression = '^;/?:@&=+\$,A-Za-z0-9\-_.!~*''()%';
startIndex = regexp( url, expression );
if ( startIndex > 0 ),
    print('###');
    return;
end;
    

return;

%{
%%% ?????????????????? ###
% --- http://www.ietf.org/rfc/rfc2396.txt ---
% scheme = alpha *( alpha | digit | "+" | "-" | "." )

if($url =~ /^([A-Za-z][A-Za-z0-9+\-.]*):/) {

# $url???????????????
 22          my $scheme = lc($1);    # ???????????
 23          my $allowed = 0;
 24          $allowed = 1 if($scheme eq 'http');
 25          $allowed = 1 if($scheme eq 'https');
 26          $allowed = 1 if($scheme eq 'mailto');
 27          return '' if(not $allowed);
 28      }
 29  
 30      ### HTML????? ###
 31      # special = "&" | "<" | ">" | '"' | "'"
 32      # URL?????????"<"?">"?'"'?$url???????
 33  
 34      $url =~ s/&/&amp;/g;         # & ? &amp;
 35      $url =~ s/'/&#39;/g;         # ' ? &#39;
 36  
 37      return $url;
 38  }

%}



