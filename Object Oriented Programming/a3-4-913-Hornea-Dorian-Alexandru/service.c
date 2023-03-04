#include "service.h"
#include <stdlib.h>
#include <string.h>



Service* createService(Repo* r){
    Service *s = (Service*)malloc(sizeof(Service));
    if(s == NULL)
        return NULL;
    s->repo = r;


    return s;
}

void destroyService(Service* s){
    if(s == NULL){
        return;
    }
    destroyRepo(s->repo);
    free(s);
}

Repo* getRepo(Service* s){
    if(s == NULL)
        return NULL;
    return s->repo;
}

int addService(Service* s, char* type, char* address, int surface, int price){
    if(s == NULL || address == NULL)
        return -1;
    Offer* o = createOffer(type, address, surface, price);
    if(o == NULL)
        return -1;

    int res = addRepo(s->repo, o);
    if(res == 0)
        destroyOffer(o);

    return res;
}

/*int updateService(Service* s, char* newType, char* address, int newSurface, int newPrice){
    if(s == NULL || address == NULL){
        return 0;
    }
    Offer* o = findByID(s->repo, address);
    if(o == NULL){
        return -1;
    }
    Operation *op = createOperation(UPDATE, p);
    if(op == NULL)
        return -1;

    add(s->undoStack, op);

    return updateRepo(s->repo, newType, address, newSurface, newPrice);
}*/

int updateService(Service* s, char* newType, char* address, int newSurface, int newPrice){
    if(s == NULL || address == NULL)
        return -1;
    return updateRepo(s->repo, newType, address, newSurface, newPrice);
}

int removeService(Service* s, char* address){
    if(s == NULL || address == NULL)
        return -1;
    int serv = removeRepo(s->repo, address);
    return serv;
}

typedef int (*sort)(Offer* o1, Offer* o2);
typedef int (*filter)(Offer* o1, Offer* o2);

int sortAscendingByPrice(Offer* o1, Offer* o2){
    if(o1->price < o2->price)
        return 1;
    return 0;
}

int filterByType(Offer* o, char* type){
    if(o->type == type)
        return 1;
    return 0;
}

int filterBySurface(Offer* o, int surface){
    if(o->surface > surface)
        return 1;
    return 0;
}

void sortVector(Vector* result, int(*sort)(Offer* o1, Offer* o2)){
    int i, j;

    for(i = 0; i < result->size-1; i++){
        for(j = i+1; j < result->size; j++){
            if((*sort)(result->data[i], result->data[j]) == 0){
                Offer* x = result->data[i];
                result->data[i] = result->data[j];
                result->data[j] = x;
            }
        }
    }
}

/*void printAllElements(Service* s){
    if(s == NULL)
        return;
    for(int i = 0; i < s->repo->vector->size; i++){
        Offer* o = createOffer(getType(s->repo->vector->data[i]), getAddress(s->repo->vector->data[i]),
                               getSurface(s->repo->vector->data[i]), getPrice(s->repo->vector->data[i]));
        printf("%s", )
    }

}*/

int filterByString(Service* s, char* string, Vector* result){
    if(s == NULL){
        return 0;
    }
    int i;
    if(strcmp(string, "-1") == 0)
    {
        for(i = 0; i < s->repo->vector->size; i++){
            Offer* o = createOffer(s->repo->vector->data[i]->type, s->repo->vector->data[i]->address, s->repo->vector->data[i]->surface, s->repo->vector->data[i]->price);
            addToVector(result, o);
        }
    }
    else{
        for(i = 0; i < s->repo->vector->size; i++){
            char* match;
            match = strstr(s->repo->vector->data[i]->address, string);
            if(match != NULL){
                Offer* o = createOffer(getType(s->repo->vector->data[i]), getAddress(s->repo->vector->data[i]),
                                       getSurface(s->repo->vector->data[i]), getPrice(s->repo->vector->data[i]));
                addToVector(result, o);
            }
        }
    }
    sort sortType = &sortAscendingByPrice;
    sortVector(result, sortType);
    return 1;
}

int filterTypeAndSurface(Service* s, char* type, int surface, Vector* result){
    if(s == NULL){
        return 0;
    }
    int i;
    for(i = 0; i < s->repo->vector->size; i++){
        Offer* o = createOffer(s->repo->vector->data[i]->type, s->repo->vector->data[i]->address,
                               s->repo->vector->data[i]->surface, s->repo->vector->data[i]->price);
        if(filterByType(o, type) && filterBySurface(o, surface)){
            addToVector(result, o);
        }
    }
    return 1;
}