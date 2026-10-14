#ifndef FUNCTIONS_H
#define FUNCTIONS_H


int init_lexic_analysis(char *);
int end_lexic_analysis();

int init_syntactic_analysis(char *);
int end_syntactic_analysis(void);

int semantic_analysis(void);

void yyerror(char *explanation);


#endif
