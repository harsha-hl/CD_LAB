%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
//extern FILE *yyin;

typedef char *string;

struct {
	string res, op1, op2;
	char op;
} code[100];
int idx = -1;
bool sameExp = false;
string addToTable(string, string, char);
void targetCode();
%}

%union {
	char *exp;
}

%token <exp> IDEN NUM
%type <exp> EXP

%left '+' '-'
%left '*' '/'

%%

STMTS	: STMTS EXP
	|
	;

EXP	: EXP '+' EXP { $$ = addToTable($1, $3, '+'); }
	| EXP '-' EXP { $$ = addToTable($1, $3, '-'); }
	| EXP '*' EXP { $$ = addToTable($1, $3, '*'); }
	| EXP '/' EXP { $$ = addToTable($1, $3, '/'); }
	| '(' EXP ')' { $$ = $2; }
	| IDEN '=' EXP { $$ = addToTable($1, $3, '='); }
	| IDEN { $$ = $1; }
	| NUM { $$ = $1; }
	;

%%

int yyerror(const char *s) {
	printf("Error %s", s);
	exit(0);
}

int main() {
	//yyin = fopen("8.txt", "r");
	yyparse();

	printf("\nTarget code:\n");
	targetCode();
}

string addToTable(string op1, string op2, char op) {
	idx++;
	if(op == '=') {
		code[idx].res = op1;
		code[idx].op1 = op2;
		code[idx].op = op;
		return op1;
	}
	
	string res = malloc(3);
	sprintf(res, "@%c", idx + 'A');

	code[idx].op1 = op1;
	code[idx].op2 = op2;
	code[idx].op = op;
	code[idx].res = res;
	return res;
}

/* 
The below function prevents the extra table entry that the above function generates

string addToTable(string op1, string op2, char op) {

	if(op == '=') {
		if(!sameExp){ // plain assignment expression
			idx++; // new table entry needed
			code[idx].res = op1;
			code[idx].op1 = op2;
			code[idx].op = op;
		}
		else{ // a prev exp is being assigned to a variable
			  // so we just change the res of exp to this identifier
			  // thus saving one table entry
			code[idx].res = op1;
		}
		sameExp = false;// next '=' will be part of a new exp for sure
		return op1;

	}
	
	idx++;
	sameExp = true;
	string res = malloc(3);
	sprintf(res, "@%c", idx + 'A');

	code[idx].op1 = op1;
	code[idx].op2 = op2;
	code[idx].op = op;
	code[idx].res = res;
	return res;
}
*/

void targetCode() {
	for(int i = 0; i <= idx; i++) {
		if(code[i].op == '='){
			printf("LOAD\t R1, %s\n", code[i].op1);
			printf("STORE\t %s, R1\n", code[i].res);
		}
		else{
		string instr;
		switch(code[i].op) {
		case '+': instr = "ADD"; break;
		case '-': instr = "SUB"; break;
		case '*': instr = "MUL"; break;
		case '/': instr = "DIV"; break;
		}

		printf("LOAD\t R1, %s\n", code[i].op1);
		printf("LOAD\t R2, %s\n", code[i].op2);
		printf("%s\t R3, R1, R2\n", instr);
		printf("STORE\t %s, R3\n", code[i].res);
		}
	}
}
