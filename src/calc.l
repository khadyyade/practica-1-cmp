%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "calc.tab.h"
#include "functions.h"

static int next_column = 1;
int token_line = 1, token_column = 1;

#define YY_USER_ACTION        \
  token_line = yylineno;      \
  token_column = next_column; \
  next_column += yyleng;      \

%}

%option yylineno
%option noyywrap
%option noinput
%option nounput

lletra  [a-zA-Z]
digit   [0-9]

%%

{lletra}({lletra}|{digit})* {
                              yylval.ident.lexema = strdup(yytext);
                              yylval.ident.lenght = yyleng;
                              yylval.ident.line = yylineno;
                              yylval.ident.id_val.val_type = UNKNOWN_TYPE;
                              return ID;
                            }

"="                         { 
                              return ASSIGN; 
                            }

{digit}({digit})*           {
                              yylval.enter = atoi(yytext);
                              return INTEGER;
                            }

^[ \t]*[\n]                 {
                              next_column = 1;
                            }

[\n]                        { 
                              next_column = 1;
                              return ENDLINE; 
                            }

[ \t]+                      { /* espacios y tabuladores: se ignoran */ }

.                           {
                              fprintf(stderr, "Línia %d, columna %d\nError lèxic: caràcter inesperat '%s'\n",token_line, token_column, yytext); 
                            }

%%

