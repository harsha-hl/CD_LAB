%{
	#include<stdio.h>
	#include<stdlib.h>
%}

%token A B C NL

%%
/*S	:	X Y NL	{printf("Valid string\n"); return;};*/
S	:	X Y	;
X	:	A X B
|
;
Y	:	B Y C
|
;
%%
int yyerror(){
	printf("Invalid string\n");
	exit(0);
}

int main(){
	printf("Enter the input string :\n");
	yyparse();
	printf("Valid string\n");
	return 0;
}
