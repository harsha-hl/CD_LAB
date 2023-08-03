%{
	#include "y.tab.h"
%}

%%
a	return A;
b	return B;
c	return C;
\n	return;
.	return yytext[0];
%%

int yywrap(){return 0;}

/*
	\n	return NL; --> then we should use X Y NL in yacc
	
	lex 1b.l
	yacc -d 1b.y
	cc lex.yy.c y.tab.c
	./a.out
*/
