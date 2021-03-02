use v6;
unit module RemoveSpaces;

sub removeSpaces ($data) is export 
{
  my $safetystr = $data;# ensure that I have an un altered copy of $data
  my @textarr = $safetystr.split(/(\#.*?\n) | (\".*?\")/, :v);#split on comments or strings by   finding "..." and #...\n
  my $blank = "";#blank string for finding spaces

  sub RmSpace($data) 
  {
    my $blank = $data; #I repurposed blank here as just a temp string
    $blank ~~ s :g /\s+//; #replace spaces in string
    #$blank.split(/\s+/);
    #$blank.split(/\s+/);
    #$data.split("");
    return $blank;
  }

  for @textarr -> $x 
  {
    #Cannot put comment on next line otherwise things get funky... This "if" just ensures that space in strings and comments remain intact
    if $x ~~ /"#".*\n | '"'.*'"'/   
    {
      $blank ~= "" ~ $x[0];
    }
    else #send string into the remove spaces function
    {
      $blank ~= RmSpace($x);
    }
  }

  $safetystr = $blank;#return correct string
  return $safetystr;
}