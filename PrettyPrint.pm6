use v6;
unit module PrettyPrint;
sub prettyPrint (@data) is export {

  my $pretty = "";  #initialize blank strings and tab strings for indenting and spacing
  my $spa = " ";#space
  my $nl = "\n";#newline
  my $s = @data;
  my $temp = "";
  for @data -> $s #move through string, reforming the string from token.value, by adding $spa and $nl most of the formatting is fixed
  {
      if $s[0] ~~ /COMMENT/
      {
      $temp = $temp ~ $pretty ~ $s.value; 
      }
      elsif $s[0] ~~ /STRING/
      {
      $temp = $temp ~ $pretty ~ $s.value; 
      }
      elsif $s[0] ~~ /VAR/
      {
      $temp = $temp ~ $pretty ~ $s.value ~ $spa; 
      }
      elsif $s[0] ~~ /KEYWORD/
      {
      $temp = $temp ~ $pretty ~ $s.value ~ $spa; 
      }
      elsif $s[0] ~~ /ASSIGNOP/
      {
      $temp = $temp ~ $pretty ~ $s.value ~ $spa; 
      }
      elsif $s[0] ~~ /INTEGER/
      {
      $temp = $temp ~ $pretty ~ $s.value; 
      }
      elsif $s[0] ~~ /EOS/
      {
      $temp = $temp ~ $pretty ~ $s.value ~ $nl; 
      }
      elsif $s[0] ~~ /LPAREN/
      {
      $temp = $temp ~ $pretty ~ $s.value; 
      }
      elsif $s[0] ~~ /RPAREN/
      {
      $temp = $temp ~ $pretty ~ $s.value ~ $spa; 
      }
      elsif $s[0] ~~ /RBRACE/
      {
      $temp = $temp ~ $pretty ~ $s.value ~ $nl ~ "\t"; #tab for braces
      }
      elsif $s[0] ~~ /LBRACE/
      {
      $temp = $temp ~ $pretty ~ $s.value ~ $nl; 
      }
      elsif $s[0] ~~ /COMPOP/
      {
      $temp = $temp ~ $pretty ~ $s.value ~$spa; 
      }
      elsif $s[0] ~~ /ARR/
      {
      $temp = $temp ~ $pretty ~ $s.value ~$spa; 
      }
  }

  $temp = $temp.subst('{'~"\n", '{'~"\n\t", :v, :g);      #fix mising tabs
  $temp = $temp.subst("\n"~'$', "\n"~"\t"~'$', :v, :g);   #fix missing tabs
  $temp = $temp.subst(';'~"\n"~'#', ';' ~ " " ~ '#', :v, :g);   #fix newline irregularities
  $temp = $temp.subst('{' ~ "\n\t" ~ '}', '{' ~ '}' , :v, :g);  #fix needless newlines
  $temp = $temp.subst("\n\t" ~ '{' ~ '}', '{' ~ '}' , :v, :g);  #fix spacing
  $temp = $temp.subst("\n" ~ '}' ~ "\n\t" ~ '}' , "\n\t" ~ '}' ~ "\n" ~ '}' , :v, :g); #fix spacing
  $temp = $temp.subst(" " ~ ';'~"\n", ';' ~ "\n" , :v, :g); #fix spacing on "x ;"
  $temp = $temp.subst(" " ~ ';' ~ " ", ';' ~ " ", :v, :g);  #fix spacing on ";"
  $temp = $temp.trim; #cleanup highlighted sections for printing
  return $temp;
}