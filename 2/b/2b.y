%{
	#include<stdio.h>
	#include<stdlib.h>
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%
S	:	I			{printf("Result is %d\n", $$); return 0;};
I	:	'(' I ')'	{$$ = $2;}
|	I '+' I			{$$ = $1 + $3;}
|	I '-' I			{$$ = $1 - $3;}
|	I '*' I			{$$ = $1 * $3;}
|	I '/' I			{if($3 == 0)yyerror(); $$ = $1/$3;}
|	NUM				{$$ = $1;}
|	'-' NUM			{$$ = -$2;}
%%

int yyerror(){
	printf("Invalid expression\n");
	exit(0);
}

int main(){
	printf("Enter arithmetic expression :\n");
	yyparse();
	return 0;
}
/*
	lex 2b.l
	yacc -d 2b.y
	cc lex.yy.c y.tab.c
	./a.out
*/
