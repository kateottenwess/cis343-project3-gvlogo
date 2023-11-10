<<<<<<< HEAD

/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
=======
/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

>>>>>>> 9543727b0fcf15a524c5ab02f4139292492f68fe
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
<<<<<<< HEAD
   
=======

>>>>>>> 9543727b0fcf15a524c5ab02f4139292492f68fe
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
<<<<<<< HEAD
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
=======

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */
>>>>>>> 9543727b0fcf15a524c5ab02f4139292492f68fe

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
<<<<<<< HEAD
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     GOTO = 258,
     WHERE = 259,
     SEP = 260,
     PENUP = 261,
     PENDOWN = 262,
     PRINT = 263,
     CHANGE_COLOR = 264,
     COLOR = 265,
     CLEAR = 266,
     TURN = 267,
     LOOP = 268,
     MOVE = 269,
     NUMBER = 270,
     END = 271,
     SAVE = 272,
     PLUS = 273,
     SUB = 274,
     MULT = 275,
     DIV = 276,
     STRING = 277,
     QSTRING = 278
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 64 "gvlogo.y"

	float f;
	char* s;



/* Line 1676 of yacc.c  */
#line 82 "gvlogo.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
=======

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_GVLOGO_TAB_H_INCLUDED
# define YY_YY_GVLOGO_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    GOTO = 258,                    /* GOTO  */
    WHERE = 259,                   /* WHERE  */
    SEP = 260,                     /* SEP  */
    PENUP = 261,                   /* PENUP  */
    PENDOWN = 262,                 /* PENDOWN  */
    PRINT = 263,                   /* PRINT  */
    CHANGE_COLOR = 264,            /* CHANGE_COLOR  */
    CLEAR = 265,                   /* CLEAR  */
    TURN = 266,                    /* TURN  */
    LOOP = 267,                    /* LOOP  */
    MOVE = 268,                    /* MOVE  */
    NUMBER = 269,                  /* NUMBER  */
    END = 270,                     /* END  */
    SAVE = 271,                    /* SAVE  */
    PLUS = 272,                    /* PLUS  */
    SUB = 273,                     /* SUB  */
    MULT = 274,                    /* MULT  */
    DIV = 275,                     /* DIV  */
    STRING = 276,                  /* STRING  */
    QSTRING = 277                  /* QSTRING  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 62 "gvlogo.y"

	float f;
	char* s;
	int i;

#line 92 "gvlogo.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
>>>>>>> 9543727b0fcf15a524c5ab02f4139292492f68fe
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
<<<<<<< HEAD
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
=======
};
>>>>>>> 9543727b0fcf15a524c5ab02f4139292492f68fe
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif

<<<<<<< HEAD
extern YYLTYPE yylloc;

=======

extern YYSTYPE yylval;
extern YYLTYPE yylloc;

int yyparse (void);


#endif /* !YY_YY_GVLOGO_TAB_H_INCLUDED  */
>>>>>>> 9543727b0fcf15a524c5ab02f4139292492f68fe
