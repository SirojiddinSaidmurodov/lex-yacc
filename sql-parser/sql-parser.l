%{
    #include "y.tab.h"
    int lineNumber = 1;
    void yyerror(char *);
    int yyparse();
    static int next_column = 1;
    int column = 1;

    #define HANDLE_COLUMN column = next_column; next_column += strlen(yytext)
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

{SELECT}            {HANDLE_COLUMN; return SELECT;}
{FROM}              {HANDLE_COLUMN; return FROM;}
{WHERE}             {HANDLE_COLUMN; return WHERE;}
{NULL_WORD}         {HANDLE_COLUMN; return NULL_WORD;}
{DEFAULT}           {HANDLE_COLUMN; return DEFAULT;}
{DISTINCT}          {HANDLE_COLUMN; return DISTINCT;}
{ASTERISK}          {HANDLE_COLUMN; return ASTERISK;}
{NOT}               {HANDLE_COLUMN; return NOT;}
{BOOLEAN_OP}        {HANDLE_COLUMN; return BOOLEAN_OP;}
{MATH_OPERATOR}     {HANDLE_COLUMN; return MATH_OPERATOR;}
{COMPARISON}        {HANDLE_COLUMN; return COMPARISON;}
\;                  {HANDLE_COLUMN; return END;}
{RB}                {HANDLE_COLUMN; return RB;}
{LB}                {HANDLE_COLUMN; return LB;}
{STRING}            {HANDLE_COLUMN; return STRING;}
{IDENTIFIER}        {HANDLE_COLUMN; return IDENTIFIER;}
\n                  {lineNumber++; HANDLE_COLUMN; next_column = 1;}
{NUMBER}            {HANDLE_COLUMN; return NUMBER;}
{COMMA}             {HANDLE_COLUMN; return COMMA;}
{DELIMITER}         ;
.                   {HANDLE_COLUMN; return(yytext[0]);}
%%
int main(int argc, char* argv[]) {
  yyparse();
  exit(0);

}
int yywrap(){
    return(1);
}