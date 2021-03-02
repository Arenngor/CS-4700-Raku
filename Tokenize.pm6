use v6;
unit module Tokenize;

sub getTokens ($data) is export { 
 my $retstr = $data;
 my @arr = $data;
  #I created a grammar for this one, so the format that it prints out isn't perfect, but it gets the job done. That is why the printing looks a little odd

  grammar RmSpace
  {
    token TOP { [ <STRING> | <COMMENT> | <VAR> | <EOS> | <LPAREN> | <RPAREN> | <KEYWORD>| <INTEGER> | <ASSIGNOP> | <LBRACE> | <RBRACE> | <COMPOP> | <ARR> | $<other> = . ] +  }
      token STRING { '"' ~ '"' .*? }
      token COMMENT { "#" ~ "\n" .*? | '#' ~ \W .*?}
      token VAR { '$' ~ \w .*? | '$' ~ \s+ .*? }# I attempted to deal with a more than single char name VAR but it does not work every time.
      token ARR { '@' ~ \w .*? }
      token KEYWORD { 'my' | 'if' | 'for' | 'else' | 'do' | 'while' }
      token ASSIGNOP { '=' | '+' | '-' }
      token INTEGER { \d }
      token EOS { ';' }
      token LPAREN { '(' }
      token RPAREN { ')' }
      token RBRACE { '}' }
      token LBRACE { '{' }
      token COMPOP { '>' | '<' }
  }

  my $a = RmSpace.parse($retstr); #parse through the string Tokenizeing it
  my @a = $a.chunks; #separate into tokens 
  return @a;
}