%{
#include <stdio.h>
#include <stdlib.h>
#include "gvlogo.tab.h"

extern void yyerror(const char* s);
%}

%%


[ \t\r\n]			{;}
(+|-|/|*)           {return EXPRESSION;}    // We might need the actual value here?
.			        { yyerror("Lexing Syntax error.\n"); } 

%%
