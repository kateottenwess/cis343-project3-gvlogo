%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "gvlogo.tab.h"

    extern void yyerror(const char* s);
%}

%option noyywrap

%%

[A-Z]{1}[a-z]+                     { yylval.s = yytext; return STRING; } 
[0-9]+                 { yylval.f = atoi(yytext); return NUMBER; } //TODO ^ I edited the above to return float when number is called
[a-z]{1}			               { yylval.c = yytext; return CHAR; }
;                                  {return SEP;}
GOTO                               {return GOTO;}
WHERE                              {return WHERE;}
CHANGE_COLOR                       {return CHANGE_COLOR;}
PENUP                              {return PENUP;}
PRINT                              {return PRINT;}
PENDOWN                            {return PENDOWN;}
CLEAR                              {return CLEAR;}
TURN                               {return TURN;}
LOOP                               {return LOOP;}
MOVE                               {return MOVE;}
END                                {return END;}
SAVE                               {return SAVE;}
RUN                                {return RUN;}
SHUTDOWN                           {return SHUTDOWN;}
\+                                 {return PLUS;}
\-                                 {return SUB;}
\*                                 {return MULT;}
=				                   {return EQUAL;}
\/                                 {return DIV;}
[ \t\r\n]			               {;}
.			                       { yyerror("Lexing Syntax error.\n"); } 

%%
