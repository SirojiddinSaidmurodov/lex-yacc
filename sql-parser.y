%token SELECT
%token FROM
%token COMMA
%token IDENTIFIER
%token WHERE
%token DISTINCT
%token ALL
%token LB
%token RB
%token NOT
%token BOOLEAN_OP
%token STRING
%token NULL_WORD
%token DEFAULT
%token NUMBER
%token END
%token MATH_OPERATOR
%token COMPARISON
%token ASTERISK
%{
    #include <stdio.h>
    #include <stdlib.h>
    int yywrap();
    int yylex();
    void yyerror(const char *str);
    extern int lineNumber;
    extern int column;
    int error_count = 0;
    void yyerror(const char *str) {
        error_count++;
        fprintf(stderr,"error: %s, line : %d, column: %d\n", str,lineNumber,column);

        if (error_count >= 3) {
            exit(-1);
        }
    }

    void printOK(){
        fprintf(stderr,"OK line: %d\n", lineNumber);
    }

%}
%%
select_list:
	select | 
	select select_list;
select:
    select_part fields_list FROM identifier_list where_part END {printOK();}|
    select_part fields_list FROM identifier_list END {printOK();};
where_part:
    WHERE condition ;
fields_list:
    ASTERISK |
    identifier_list;
identifier_list:
    IDENTIFIER |
    identifier_list COMMA IDENTIFIER |
    IDENTIFIER {yyerror("Commma missed");} IDENTIFIER |
    {yyerror("Missed identifier ");};
select_part:
    SELECT DISTINCT |
    SELECT ALL |
    SELECT |
    {yyerror("Missed SELECT ");};
condition:
    condition_factor |
    RB condition_factor LB;
condition_factor:
    predicate |
    predicate BOOLEAN_OP condition;
predicate:
    NOT field_value COMPARISON field_value |
    field_value COMPARISON field_value;
field_value:
    IDENTIFIER |
    value;
number_expression:
    number_factor |
    RB number_factor LB;
number_factor:
    NUMBER |
    NUMBER MATH_OPERATOR number_expression |
    NUMBER number_expression {yyerror("Missed math operator");};
value:
    STRING |
    number_expression |
    NULL_WORD |
    DEFAULT;
%%
