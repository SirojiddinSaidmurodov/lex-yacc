%{
    int lineNumber = 1;
%}
DELIMITER           [ \t\r]*
COMMA               [,]
PUNCTUATION_MARKS   [\.{COMMA}\?!;:]
DIGIT               [0-9]
LETTER              [a-zA-Z]
NUMBER              -?{DIGIT}+
SYMBOL              ({DIGIT}|{LETTER}|{PUNCTUATION_MARKS})
STRING              '{SYMBOL}+'
IDENTIFIER          ({LETTER}|_)({LETTER}|_|{DIGIT})*
/* FIELDS_LIST          {IDENTIFIER}({DELIMITER},{DELIMITER}{IDENTIFIER})* */
ASTERISK            \*
MATH_OPERATOR       \+|\-|\/|{ASTERISK}
NULL_WORD           [Nn][Uu][Ll][Ll]
DEFAULT             [Dd][Et][Ff][Aa][Uu][Ll][Tt]
/* VALUE               STRING|{NULL_WORD}|{DEFAULT} */
EQ                  =
COMPARISON          <>|<|>|<=|>=|{EQ}
OR                  [Oo][Rr]
AND                 [Aa][Nn][Dd]
BOOLEAN_OP          {OR}|{AND}
NOT                 [Nn][Oo][Tt]
SELECT              [Ss][Ee][Ll][Ee][Cc][Tt]
DISTINCT            [Dd][Ii][Ss][Tt][Ii][Nn][Cc][Tt]
FROM                [Ff][Rr][Oo][Mm]
WHERE               [Ww][Hh][Ee][Rr][Ee]
/* ORDER_BY            [Oo][Rr][Dd][Ee][Rr]{DELIMITER}[Bb][Yy]
 ASC                 [Aa][Ss][Cc]
 DESC                [Dd][Ee][Ss][Cc]
 SORT                {ASC}|{DESC}
 GROUP_BY            [Gg][Rr][Oo][Uu][Pp]{DELIMITER}[Bb][Yy]
*/
RB                  \(
LB                  \)

%%

{SELECT}            printf("SELECT");
{FROM}              printf("FROM");
{WHERE}             printf("WHERE");
{NULL_WORD}         printf("NULL_WORD");
{DEFAULT}           printf("DEFAULT");
{DISTINCT}          printf("DISTINCT");
{ASTERISK}          printf("ASTERISK");
{NOT}               printf("NOT");
{BOOLEAN_OP}        printf("BOOLEAN_OP");
{MATH_OPERATOR}     printf("MATH_OPERATOR");
{COMPARISON}        printf("COMPARISON");
\;                  printf("END");
{RB}                printf("RB");
{LB}                printf("LB");
{STRING}            printf("STRING");
{IDENTIFIER}        printf("IDENTIFIER");
\n                  {lineNumber++;
                      printf("\n");}
{NUMBER}            printf("NUMBER");
{COMMA}             printf("COMMA");
{DELIMITER}         printf(" ");
.                   return(yytext[0]);
%%