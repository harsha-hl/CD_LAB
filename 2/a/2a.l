%{
#include <stdio.h>
int posint = 0, negint = 0, posfrac = 0, negfrac = 0;
%}

num [0-9]+

posint \+?{num}
negint -{num}

posnum {posint}\.{num}?|\+?\.{num}|{posint}
negnum {negint}\.{num}?|-\.{num}|{negint}

%%

{posint} posint++;

{negint} negint++;

{posnum} posfrac++;

{negnum} negfrac++;

{posnum}\/{posnum} |
{negnum}\/{negnum} posfrac++;

{posnum}\/{negnum} |
{negnum}\/{posnum} negfrac++;

[ \t] ;

[\n] return;

. ECHO;

%%

int yywrap(){}

int main() {
	printf("Enter the space separated numbers\n");
	yylex();
	printf("Positive integers: %d\n", posint);
	printf("Negative integers: %d\n", negint);
	printf("Positive fractions: %d\n", posfrac);
	printf("Negative fractions: %d\n", negfrac);
}

/*
	lex 2a.l
	cc lex.yy.c
	./a.out
*/
