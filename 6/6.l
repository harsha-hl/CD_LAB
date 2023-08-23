%{
#include <string.h>

#include "y.tab.h"
%}


%%

[a-zA-Z_][a-zA-Z_0-9]* {
	yylval.exp = strdup(yytext);
	return IDEN;
}

[0-9]+ {
	yylval.exp = strdup(yytext);
	return NUM;
}

[ \t] ;

\n	return '\n';

#	return 0;

. return yytext[0];

%%

int yywrap(){return 0;}
