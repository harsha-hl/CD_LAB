%{
    #include<stdio.h>
    #include<stdlib.h>
%}

%token TYPE IDEN NUM RET
 
%%
S: FUN  {printf("Accepted\n");exit(0);}
;
FUN:    TYPE IDEN '(' A ')' '{' B '}'
;
A: X
|
;
X: X ',' TYPE IDEN
| TYPE IDEN
;
B: E ';' B
| RET E ';'
|
;
E:IDEN Z IDEN
|IDEN Z NUM
|IDEN U
|IDEN
;
Z:'='|'>'|'<'|'<''='|'>''='|'=''+'|'=''-'
;
U:'+''+'|'-''-' 
;
%%
int main()
{
    printf("enter input: ");
    yyparse();
    printf("successfull\n");
    return 0;
}
int yyerror()
{
    printf("ERROR\n");
    exit(0);
}
