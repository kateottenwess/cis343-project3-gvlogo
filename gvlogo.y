%{
#define WIDTH 640
#define HEIGHT 480

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>
#include <SDL_thread.h>

static SDL_Window* window;
static SDL_Renderer* rend;
static SDL_Texture* texture;
static SDL_Thread* background_id;
static SDL_Event event;
static int running = 1;
static const int PEN_EVENT = SDL_USEREVENT + 1;
static const int DRAW_EVENT = SDL_USEREVENT + 2;
static const int COLOR_EVENT = SDL_USEREVENT + 3;

typedef struct color_t {
	unsigned char r;
	unsigned char g;
	unsigned char b;
} color;

static color current_color;

static double x = WIDTH / 2;
static double y = HEIGHT / 2;
static int pen_state = 1;
static double direction = 0.0;
static int variable[26];

int yylex(void);
int yyerror(const char* s);
void startup();
int run(void* data);
void prompt();
void penup();
void pendown();
void move(int num);
void turn(int dir);
void output(const char* s);
void change_color(int r, int g, int b);
void clear();
void save(const char* path);
void shutdown();
void goTo(float new_x, float new_y);	// TODO
void where();				// TODO
void store_variables(int *variable, char variable_name, int expression_result);

%}

%union {		// add color rgb to here?
	float f;
	char* s;
	char c;
	int i;
}

%locations 
%token RUN
%token SHUTDOWN
%token GOTO
%token WHERE
%token SEP
%token PENUP
%token PENDOWN
%token PRINT
%token CHANGE_COLOR
%token CLEAR
%token TURN
%token LOOP
%token MOVE
%token NUMBER
%token END
%token SAVE
%token PLUS SUB MULT DIV EQUAL
%token<s> STRING QSTRING		// fix?
%token<c> CHAR					// Fix?
%type<f> expression expression_list NUMBER

%%

// When he tells us to Modify the CFG to allow a variable value in the move,turn,and goto commands, 
// I think he wants those commands to take in a variable as input, instead of an int.

program:		statement_list END			{ printf("Program complete."); shutdown(); exit(0); }
		;
statement_list:		statement					
		|	statement statement_list
		;
statement:		command SEP					{ prompt(); }
		|	error '\n' 					    { yyerror; prompt(); }
		;

// Add definition for variable here?????

command:		PENUP						{ penup(); }
	   	|		PENDOWN						{ pendown(); }
		|		PRINT STRING				{ output($2); }
		|		CLEAR						{ clear(); }
		|		GOTO expression expression	{ goTo($2, $3); }
		|		WHERE						{ where(); }
		|		CHANGE_COLOR expression expression expression	{ change_color($2, $3, $4); }
		|		TURN expression						{ turn($2); }
		|		MOVE NUMBER 					    { move($2); }
		|		SAVE STRING							{ save($2); }
		|       SHUTDOWN  						    { shutdown(); }
		|		CHAR EQUAL expression_list			{ store_variables(variable, $1, $3); }      // MY attempt at -> (variable location in array) = (the expression) 
		;
expression_list:	expression				   // Complete these and any missing rules
		|		expression expression_list   
		|       expression PLUS expression_list 		
		;
expression:		NUMBER PLUS expression				{ $$ = $1 + $3; }
		|		NUMBER MULT expression				{ $$ = $1 * $3; }
		|		NUMBER SUB expression				{ $$ = $1 - $3; }
		|		NUMBER DIV expression				{ $$ = $1 / $3; }
		|		NUMBER							
		;

%%

int main(int argc, char** argv){
	startup();
	return 0;
}

int yyerror(const char* s){
	printf("Error: %s\n", s);
	return -1;
};

void prompt(){
	printf("gv_logo > ");
}

void penup(){
	event.type = PEN_EVENT;		
	event.user.code = 0;
	SDL_PushEvent(&event);
}

void pendown() {
	event.type = PEN_EVENT;		
	event.user.code = 1;
	SDL_PushEvent(&event);
}

void move(int num){
	printf("This is the num being sent: %d \n", num);
	event.type = DRAW_EVENT;
	event.user.code = 1;
	event.user.data1 = (void*)num;
	SDL_PushEvent(&event);
}

void turn(int dir){
	event.type = PEN_EVENT;
	event.user.code = 2;
	event.user.data1 = dir;
	SDL_PushEvent(&event);
}

void output(const char* s){
	printf("%s\n", s);
}

void change_color(int r, int g, int b){
	event.type = COLOR_EVENT;
	current_color.r = r;
	current_color.g = g;
	current_color.b = b;
	SDL_PushEvent(&event);
}

void clear(){
	event.type = DRAW_EVENT;
	event.user.code = 2;
	SDL_PushEvent(&event);
}

void startup(){
	SDL_Init(SDL_INIT_VIDEO);
	window = SDL_CreateWindow("GV-Logo", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, WIDTH, HEIGHT, SDL_WINDOW_SHOWN);
	if (window == NULL){
		yyerror("Can't create SDL window.\n");
	}
	
	//rend = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_TARGETTEXTURE);
	rend = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE | SDL_RENDERER_TARGETTEXTURE);
	SDL_SetRenderDrawBlendMode(rend, SDL_BLENDMODE_BLEND);
	texture = SDL_CreateTexture(rend, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, WIDTH, HEIGHT);
	if(texture == NULL){
		printf("Texture NULL.\n");
		exit(1);
	}
	SDL_SetRenderTarget(rend, texture);
	SDL_RenderSetScale(rend, 3.0, 3.0);

	background_id = SDL_CreateThread(run, "Parser thread", (void*)NULL);
	if(background_id == NULL){
		yyerror("Can't create thread.");
	}
	while(running){
		SDL_Event e;
		while( SDL_PollEvent(&e) ){
			if(e.type == SDL_QUIT){
				running = 0;
			}
			if(e.type == PEN_EVENT){
				if(e.user.code == 2){
					double degrees = ((int)e.user.data1) * M_PI / 180.0;
					direction += degrees;
				}
				pen_state = e.user.code;
			}
			if(e.type == DRAW_EVENT){
				if(e.user.code == 1){
					int num = (int)event.user.data1;
					double x2 = x + num * cos(direction);
					double y2 = y + num * sin(direction);
					if(pen_state != 0){
						SDL_SetRenderTarget(rend, texture);
						SDL_RenderDrawLine(rend, x, y, x2, y2);
						SDL_SetRenderTarget(rend, NULL);
						SDL_RenderCopy(rend, texture, NULL, NULL);
					}
					x = x2;
					y = y2;
				} else if(e.user.code == 2){
					SDL_SetRenderTarget(rend, texture);
					SDL_RenderClear(rend);
					SDL_SetTextureColorMod(texture, current_color.r, current_color.g, current_color.b);
					SDL_SetRenderTarget(rend, NULL);
					SDL_RenderClear(rend);
				}
			}
			if(e.type == COLOR_EVENT){
				SDL_SetRenderTarget(rend, NULL);
				SDL_SetRenderDrawColor(rend, current_color.r, current_color.g, 0, 255);
			}
			if(e.type == SDL_KEYDOWN){
			}

		}
		//SDL_RenderClear(rend);
		SDL_RenderPresent(rend);
		SDL_Delay(1000 / 60);
	}
}

int run(void* data){
	prompt();
	yyparse();
}

void shutdown(){
	running = 0;
	SDL_WaitThread(background_id, NULL);
	SDL_DestroyWindow(window);
	SDL_Quit();
}

void save(const char* path){
	SDL_Surface *surface = SDL_CreateRGBSurface(0, WIDTH, HEIGHT, 32, 0, 0, 0, 0);
	SDL_RenderReadPixels(rend, NULL, SDL_PIXELFORMAT_ARGB8888, surface->pixels, surface->pitch);
	SDL_SaveBMP(surface, path);
	SDL_FreeSurface(surface);
}

//TODO test
void goTo(float new_x, float new_y) {
	//change current coordinates

	if( new_x > x)
	{	
		turn(90);
		move(new_x - x);
		turn(-90);
	}
	else if (new_x < x){
		turn(-90);
		move(x - new_x);
		turn(90);
	}

	if(new_y > y){
		move(new_y - y);
	}
	else if( new_y < y){
		turn(180);
		move(y - new_y);
		turn(180);
	}
}


//TODO test this
void where() {
	//print current coordinates
	printf("Current coordinates: (%f, %f)\n", x, y);
}

void store_variables(int *variable, char variable_name, int expression_result) {
	// we can always take ascii value and subtract val of lowercase a (a-a = 0) (b-a = 1) etc.
	switch(variable_name) {
		case 'a':
			variable[0] = expression_result;
			break;
		case 'b':
			variable[1] = expression_result;
			break;
		case 'c':
			variable[2] = expression_result;
			break;
		case 'd':
			variable[3] = expression_result;
			break;
		case 'e':
			variable[4] = expression_result;
			break;
		case 'f':
			variable[5] = expression_result;
			break;
		case 'g':
			variable[6] = expression_result;
			break;
		case 'h':
			variable[7] = expression_result;
			break;
		case 'i':
			variable[8] = expression_result;
			break;
		case 'j':
			variable[9] = expression_result;
			break;
		case 'k':
			variable[10] = expression_result;
			break;
		case 'l':
			variable[11] = expression_result;
			break;
		case 'm':
			variable[12] = expression_result;
			break;
		case 'n':
			variable[13] = expression_result;
			break;
		case 'o':
			variable[14] = expression_result;
			break;
		case 'p':
			variable[15] = expression_result;
			break;
		case 'q':
			variable[16] = expression_result;
			break;
		case 'r':
			variable[17] = expression_result;
			break;
		case 's':
			variable[18] = expression_result;
			break;
		case 't':
			variable[19] = expression_result;
			break;
		case 'u':
			variable[20] = expression_result;
			break;
		case 'v':
			variable[21] = expression_result;
			break;
		case 'w':
			variable[22] = expression_result;
			break;
		case 'x':
			variable[23] = expression_result;
			break;
		case 'y':
			variable[24] = expression_result;
			break;
		case 'z':
			variable[25] = expression_result;
			break;
	}
}
