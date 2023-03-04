#pragma once
#include "service.h"

typedef struct{
    Service* s;
}UI;

UI* createUI(Service* s);

void destroyUI(UI *ui);

void print_menu();

int addUI(UI* ui);

int removeUI(UI* ui);

int updateUIType(UI* ui);

int updateUISurface(UI* ui);

int updateUIPrice(UI* ui);

void listAllOffers(UI* ui);

int listByString(UI* ui);

int validInput(int input);

int readInteger(const char* message);

void start(UI* ui);
