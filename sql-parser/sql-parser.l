DELIMITER           [ \t\n]*
PUNCTUATION_MARKS   [\.,\?!;:]
DIGIT               [0-9]
LETTER              [a-zA-Z]
NUMBER              -?{DIGIT}+
SYMBOL              [{DIGIT}{LETTER}{PUNCTUATION_MARKS}{DELIMITER}]
STRING              {SYMBOL}+
IDENTIFIER          [{LETTER}_][{LETTER}_{DIGIT}]*
FIELDS_LIST         {IDENTIFIER}(,{IDENTIFIER})*
MATH_OPERATOR       [/+/-/*//]
/*
MATH_FACTOR         {NUMBER}|{NUMBER}{MATH_OPERATOR}{MATH_EXP}
MATH_EXP            {MATH_FACTOR}|\({MATH_FACTOR}\)
*/
NULL                [Nn][Uu][Ll][Ll]
DEFAULT             [Dd][Et][Ff][Aa][Uu][Ll][Tt]
VALUE               {STRING}|{NULL}|{DEFAULT}
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
{IDENTIFIER}        printf("IDENTIFIER");
{MATH_OPERATOR}     printf("MATH_OPERATOR");
{NUMBER}            printf("NUMBER");
{NULL}              printf("NULL");
{DEFAULT}           printf("DEFAULT");
{VALUE}             printf("VALUE");
{COMPARISON}        printf("COMPARISON");
{OR}                printf("OR");
{AND}               printf("AND");
{NOT}               printf("NOT");
{SELECT}            printf("SELECT");
{DISTINCT}          printf("DISTINCT");
{FROM}              printf("FROM");
{WHERE}             printf("WHERE");
{FIELDS_LIST}       printf("FIELDS_LIST");
{DELIMITER}         printf(" ");
{RB}                printf("RB");
{LB}                printf("LB");
.                   ;

%%
