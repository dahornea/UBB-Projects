#include "domain.h"
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <stdlib.h>

Offer* createOffer(char* type, char* address, int surface, int price){
    Offer* o = malloc(sizeof(Offer));
    if(o == NULL){
        return NULL;
    }

    o->type = malloc(sizeof(char) * strlen(type) + 1);
    if(o->type != NULL){
        strcpy(o->type, type);
    }

    o->address = malloc(sizeof(char) * strlen(address) + 1);
    if(o->address != NULL){
        strcpy(o->address, address);
    }

    o->surface = surface;
    o->price = price;

    return o;
}

void destroyOffer(Offer* o){
    if(o == NULL)
        return;

    free(o->type);
    free(o->address);

    free(o);
}

const char* getType(Offer* o){
    if(o == NULL)
        return NULL;
    return o->type;
}

const char* getAddress(Offer* o){
    if(o == NULL)
        return NULL;
    return o->address;
}

int getSurface(Offer* o){
    if(o == NULL)
        return -1;
    return o->surface;
}

int getPrice(Offer* o){
    if(o == NULL)
        return -1;
    return o->price;
}

void setType(Offer* o, char* type){
    free(o->type);
    o->type = (char*)malloc((strlen(type)+1)* sizeof(char));
    strcpy(o->type, type);
}

void setAddress(Offer* o, char* address){
    free(o->address);
    o->address = (char*)malloc((strlen(address)+1) * sizeof(char));
    strcpy(o->address, address);
}

void setSurface(Offer* o, int newSurface){
    o->surface = newSurface;
}

void setPrice(Offer* o, int newPrice){
    o->price = newPrice;
}

void toString(Offer* o, char str[]){
    if(o == NULL){
        return;
    }
    sprintf(str, "Offer: %s, found at: %s, has a total surface of: %d and it costs: %d", o->type, o->address, o->surface, o->price);
}

Offer* copyOffer(Offer* o){
    if(o == NULL)
        return NULL;
    return createOffer(o->type, o->address, o->surface, o->price);
}

void testOffer(){
    Offer* o = createOffer("house", "Tiglina 1", 55, 100000);
    assert(strcmp(o->type, "house") == 0);
    assert(strcmp(o->address, "Tiglina 1") == 0);
    assert(o->surface == 55);
    assert(o->price == 100000);
    assert(strcmp(getType(o), "house") == 0);
    assert(strcmp(getAddress(o), "Tiglina 1") == 0);
    assert(getSurface(o) == 55);
    assert(getPrice(o) == 100000);
    setType(o, "apartment");
    assert(strcmp(getType(o), "apartment") == 0);
    setAddress(o, "Potcoava");
    assert(strcmp(getAddress(o), "Potcoava") == 0);
    setSurface(o, 60);
    assert(getSurface(o) == 60);
    setPrice(o, 50000);
    assert(getPrice(o) == 50000);
}