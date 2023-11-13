%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "gvlogo.tab.h"

    extern void yyerror(const char* s);
%}

%%

[A-Z]{1}[a-z]+                     { yylval.s = yytext; return STRING; } 
[0-9]+                             { yylval.i = atoi(yytext); return NUMBER; }
[a-z]{1}			               { yylval.c = yytext; return CHAR; }
;                                  {return SEP;}
GOTO                               {return GOTO;}
WHERE                              {return WHERE;}
CHANGE_COLOR                       {return CHANGE_COLOR;}
PENUP                              {return PENUP;}
PENDOWN                            {return PENDOWN;}
CLEAR                              {return CLEAR;}
TURN                               {return TURN;}
LOOP                               {return LOOP;}
MOVE                               {return MOVE;}
END                                {return END;}
SAVE                               {return SAVE;}
RUN                                {return RUN;}
SHUTDOWN                           {return SHUTDOWN;}
\+                                {return PLUS;}
\-                                {return SUB;}
\*                                {return MULT;}
=				                   {return EQUAL;}
\/                                {return DIV;}
[ \t\r\n]			               {;}
.			                       { yyerror("Lexing Syntax error.\n"); } 

%%
