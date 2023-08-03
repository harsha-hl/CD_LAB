%{
    #include <stdio.h>
    #include <stdlib.h>
    int ids = 0;
%}
%token ID NUM TYPE
%%
S:	S D
 |
 ;
D: TYPE L ';'
 ;
L: L ',' A
 | A
 ;
A: ID '[' NUM ']'	{ids++;}
 | ID				{ids++;}
 ;
%%
int main(){
	printf("Enter the statements\n");
    yyparse();
    printf("Number of identifiers declared is %d\n", ids);
}
int yyerror(const char *s){
    printf("Error\n");
    exit(0);
}
