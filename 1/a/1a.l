%{
	#include<stdio.h>
	int lines=0,chars=0,words=0,spaces=0;
%}

%%
\n	lines++;
\t	spaces+=4;
[ ]	spaces++;
#	return;
[^ \t\n#]+ {words++;chars+=yyleng;} //[^ \t\n#] not space, tab, line, #
%%

int yywrap()
{
	return 0;
}

int main()
{
	printf("Enter the string:\n");
	yylex();
	printf("Lines: %d\nWords: %d\nChars: %d\nSpaces: %d\n",lines,words,chars,spaces);
	return 0;
}

/*
	lex 1a.l
	cc lex.yy.c
	./a.out
*/
