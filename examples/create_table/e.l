%{
    int lineNumber = 1;
    int yylex();
    void yyerror(char *);
%}


number                          [0-9]
letter                          [a-zA-Z]
non_negative_integer            {number}+
identifier                      ({letter}|_)({letter}|_|{number})*



%%
CREATE                                                                      printf("CREATE");
GLOBAL                                                                      printf("GLOBAL");
LOCAL                                                                       printf("LOCALE");
TEMPORARY                                                                   printf("TEMPORARY");
TABLE                                                                       printf("TABLE");
ON\ COMMIT                                                                  printf("ON_COMMIT");
DELETE                                                                      printf("DELETE");
PRESERVE                                                                    printf("PRESERVE");      
ROWS                                                                        printf("ROWS");
REFERENCES                                                                  printf("REFERENCES");
UNIQUE | 
PRIMARY\ KEY | 
NOT\ NULL                                                                   printf("LIMITATION_OF_UNIQUENESS");
ON\ UPDATE                                                                  printf("ON_UPDATE");
ON\ DELETE                                                                  printf("ON_DELETE");
CASCADE |
SET\ NULL |
SET\ DEFAULT |
NO\ ACTION                                                                  printf("TRIGGER");
FOREIGN\ KEY                                                                printf("FOREIGN_KEY");

CHAR\({non_negative_integer}\)? |
VARCHAR\({non_negative_integer}\)?                                          printf("STRING_DATA_TYPE");
NUMERIC\({non_negative_integer}\,\ ?{non_negative_integer}?\)? |
INTEGER |
FLOAT\({non_negative_integer}\)? | 
REAL                                                                        printf("NUMERICAL_DATA_TYPE");
DATE | 
TIME\({non_negative_integer}\)?                                             printf("TIME_DATA_TYPE");

{identifier}                                                                printf("ID");
{non_negative_integer}                                                      printf("NUMBER");

\(                                                                          printf("(RB)");
\)                                                                          printf("(LB)");
\;                                                                          printf("(SEMICOLON)");
[ \t]+                                                                      printf(" ");
\n                                                                          {lineNumber++; 
                                                                            printf("\n");};
,                                                                           printf(",");
.                                                                           {yyerror(yytext);};
%%

void yyerror(char *s){
    printf("\nERROR: illegal symbol on line: %d.\n", lineNumber);
    exit(1);
}
