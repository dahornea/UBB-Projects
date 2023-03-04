#include "repository.h"
#include "dynamicArray.h"
#include "domain.h"
#include <string.h>
#include <stdlib.h>
#include <assert.h>

Repo* createRepo(int capacity){
    Repo* r = malloc(sizeof(Repo) );
    if(r == NULL){
        return NULL;
    }
    r->vector = createVector(capacity);

    return r;
}

void destroyRepo(Repo* r){
    if(r == NULL){
        return;
    }
    destroyVector(r->vector);
    free(r);
}

int getLengthRepo(Repo* r){
    return r->vector->size;
}

int existingId(Offer* o1, Offer* o2){
    if(strcmp(o1->address, o2->address) == 0){
        return 1;
    }
    return 0;
}

void swapOffers(Offer* x, Offer* y){
    Offer aux = *x;
    *x = *y;
    *y = aux;
}

Offer* getOfferOnPos(Repo* r, int pos){
    if(r == NULL){
        return NULL;
    }
    if(pos < 0 || pos >= getLengthRepo(r)){
        return NULL;
    }
    return r->vector->data[pos];
}

int getPosOfOffer(Repo* r, Offer* o){
    if(r == NULL)
        return -1;

    if(o == NULL)
        return -1;


    for(int i = 0; i < r->vector->size; i++){
        if(r->vector->data[i] == o)
            return i;

    }
    return -1;
}

Offer* findByID(Repo* r, char* address){
    if(r == NULL || address == NULL)
        return NULL;

    for(int i = 0; i < r->vector->size; i++){
        Offer* o = get(r->vector, i);
        if(strcmp(getAddress(o), address) == 0)
            return o;
    }
    return NULL;
}

int addRepo(Repo* r, Offer* o){
    addToVector(r->vector, o);
    return 1;
}

int removeRepo(Repo* r, char* address){
    if(r == NULL || address == NULL)
        return -1;

    Offer* o = findByID(r, address);
    for(int i = 0; i < r->vector->size; i++){
        if(get(r->vector, i) == o){
            removeFromVector(r->vector, i);
            return 1;
        }
    }
    return 0;
}



int updateRepo(Repo* r, char* newType, char* address, int newSurface, int newPrice) {
    if(r == NULL || address == NULL)
        return 0;
    Offer* o = findByID(r, address);
    int pos = getPosOfOffer(r, o);
    if(pos == -1)
        return 0;

    setType(r->vector->data[pos], newType);
    setSurface(r->vector->data[pos], newSurface);
    setPrice(r->vector->data[pos], newPrice);

    return 1;
}


void initOfferRepoTest(Repo* r){
    Offer* o = createOffer("house", "Tiglina 2", 50, 20000);
    addRepo(r, o);
}

void testAdd(){
    Repo* r = createRepo(10);
    initOfferRepoTest(r);
    assert(getLengthRepo(r) == 1);
    Offer* o = createOffer("penthouse", "Dunarii", 40, 90000);
    assert(addRepo(r, o) == 1);
    assert(getLengthRepo(r) == 2);
    destroyRepo(r);
}

void testRemove(){
    Repo* r = createRepo(10);
    initOfferRepoTest(r);
    assert(getLengthRepo(r) == 1);
    assert(removeRepo(r, "Tiglina 2") == 1);
    assert(getLengthRepo(r) == 0);
    assert(removeRepo(r, "Tiglina 3") == 0);
    destroyRepo(r);
}

void testUpdate(){
    Repo* r = createRepo(10);
    initOfferRepoTest(r);
    assert(updateRepo(r, "apartment", "Tiglina 2", 40, 25000) == 1);
    assert(getPrice(r->vector->data[0]) == 25000);
    assert(getSurface(r->vector->data[0]) == 40);

    destroyRepo(r);
}

void testRepo(){
    testAdd();
    testRemove();
    testUpdate();
}