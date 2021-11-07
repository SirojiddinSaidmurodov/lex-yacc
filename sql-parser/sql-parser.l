%{
    int lineNumber = 1;
    void yyerror(char *);
%}
DELIMITER           [ \t\r]*
PUNCTUATION_MARKS   [\.,\?!;:]
DIGIT               [0-9]
LETTER              [a-zA-Z]
NUMBER              -?{DIGIT}+
SYMBOL              [{DIGIT}{LETTER}{PUNCTUATION_MARKS}{DELIMITER}]
STRING              {SYMBOL}+
IDENTIFIER          ({LETTER}|_)({LETTER}|_|{DIGIT})*
FIELDS_LIST         {IDENTIFIER}({DELIMITER},{DELIMITER}{IDENTIFIER})*
MATH_OPERATOR       [/+/-/*//]
/*
MATH_FACTOR         {NUMBER}|{NUMBER}{MATH_OPERATOR}{MATH_EXP}
MATH_EXP            {MATH_FACTOR}|\({MATH_FACTOR}\)
*/
NULL                [Nn][Uu][Ll][Ll]
DEFAULT             [Dd][Et][Ff][Aa][Uu][Ll][Tt]
VALUE               [('{STRING}'){NULL}{DEFAULT}]
EQ                  =
COMPARISON          <>|<|>|<=|>=|{EQ}
OR                  [Oo][Rr]
AND                 [Aa][Nn][Dd]
NOT                 [Nn][Oo][Tt]
/*
FIELD_VALUE         {VALUE}|{IDENTIFIER}
PREDICATE           {NOT}?{FIELD_VALUE}{COMPARISON}{FIELD_VALUE}
CONDITION_FACTOR    {PREDICATE}|{PREDICATE}{BOLEAN_OP}{CONDITION}
CONDITION           {CONDITION_FACTOR}|\({CONDITION_FACTOR}\)
*/
SELECT              [Ss][Ee][Ll][Ee][Cc][Tt]
DISTINCT            [Dd][Ii][Ss][Tt][Ii][Nn][Cc][Tt]
FROM                [Ff][Rr][Oo][Mm]
WHERE               [Ww][Hh][Ee][Rr][Ee]
RB                  \(
LB                  \)

%%
{SELECT}            printf("SELECT");
{DELIMITER}         printf(" ");
{MATH_OPERATOR}     printf("MATH_OPERATOR");
{NUMBER}            printf("NUMBER");
{NULL}              printf("NULL");
{DEFAULT}           printf("DEFAULT");
{COMPARISON}        printf("COMPARISON");
{OR}                printf("OR");
{AND}               printf("AND");
{NOT}               printf("NOT");
{DISTINCT}          printf("DISTINCT");
{FROM}              printf("FROM");
{WHERE}             printf("WHERE");
{IDENTIFIER}        printf("IDENTIFIER");
{FIELDS_LIST}       printf("FIELDS_LIST");
\;                  printf("END");
{RB}                printf("RB");
{LB}                printf("LB");
\n                  {lineNumber++;printf("\n");}
{VALUE}             printf("VALUE");
.                   {yyerror(yytext);};
%%
void yyerror(char *s){
    printf("\nERROR: illegal symbol on line: %d.\n", lineNumber);
    printf("near '%s'\n", s);
}