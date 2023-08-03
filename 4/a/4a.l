%{
	#include<stdio.h>
	int ids=0, ops=0, keys=0;
%}
key	"int"|"double"|"float"|"bool"|"main"|"for"
op	"="|"+"|"-"|"*"|"/"|"<="|">="|"++"|"<"
%%
{key}	keys++;
{op}	ops++;
[a-zA-z_][a-zA-z0-9_]*	ids++;
#	return 0;
.	;
\n	;
%%

int yywrap(){return 0;}

int main(){
	yyin = fopen("inp.txt", "r");
	yylex();
	printf("Identifiers : %d\nOperators : %d\nKeywords : %d\n", ids, ops, keys);
	return 0;
}
