%{
	#include<stdio.h>
	int single=0,multi=0,mlines=0;
%}
start	\/\*
end		\*\/
%%
\/\/[^\n]*	{single++;}
{start}[^*]*{end}	{
	multi++;
	for(int i=0;i<yyleng;i++)
	{
		if(yytext[i]=='\n')
			mlines++;
	}
}
%%
int yywrap()
{
	return 1;
}
int main()
{
	yyin=fopen("inp.txt","r");
	yyout=fopen("out.txt","w");
	yylex();
	printf("Single: %d\n Multi: %d\nMlines: %d\n",single,multi,mlines);
	return 0;
}
/*
	lex 3a.l
	cc lex.yy.c
	./a.out
*/
