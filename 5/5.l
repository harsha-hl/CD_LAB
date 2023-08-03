%{
    #include "y.tab.h"
%}
type	"int"|"float"|"char"|"double"
%%
{type}	return TYPE;
[0-9]* return NUM;
[a-zA-Z_][a-zA-Z0-9_]* return ID;
[ \t\n]	;
#	return 0;
. return yytext[0];
%%
int yywrap(){return 0;}

