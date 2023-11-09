%{
#include <stdio.h>
#include <stdlib.h>
#include "gvlogo.tab.h"
%option noyywrap

extern void yyerror(const char* s);
%}

%%

[A-Z]{1}[a-z]+.                    { yylval.str = yytext; return STRING; } 
[0-9]+                             { yylval.num = atoi(yytext); return NUMBER; }
;                                  {return SEP;}
GOTO                               {return GOTO;}
WHERE                              {return WHERE}
CHANGE_COLOR                       {return CHANGE_COLOR;}
PENUP                              {return PENUP;}
PENDOWN                            {return PENDOWN;}
CLEAR                              {return CLEAR;}
TURN                               {return TURN;}
LOOP                               {return LOOP;}
MOVE                               {return MOVE;}

[+]                                {return PLUS;}
[-]                                {return SUB;}
[*]                                {return MULT;}
[/]                                {return DIV;}
[ \t\r\n]			               {;}
.			                       { yyerror("Lexing Syntax error.\n"); } 

%%
