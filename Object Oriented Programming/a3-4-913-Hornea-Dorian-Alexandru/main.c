#include "repository.h"
#include "ui.h"
#include <crtdbg.h>
#include <stdio.h>
#include <stdlib.h>
#include <dynamicArray.h>

void tests(){
    testOffer();
    testRepo();
    testVector();
    //testService();
    printf("Tests passed succesfully.\n");
}

int main(){
    Repo* repo = createRepo();
    Service* service = createService(repo);

    addService(service, "house", "Tiglina 1", 60, 20000);
    addService(service, "apartment", "Dunarii", 55, 70000);
    addService(service, "penthouse", "Centru", 75, 150000);
    addService(service, "house", "Magnus", 45, 55000);
    addService(service, "apartment", "Micro 19", 50, 45000);
    addService(service, "penthouse", "Sendreni", 130, 200000);

    UI* ui = createUI(service);

    tests();
    start(ui);
    destroyUI(ui);
    printf("%d", _CrtDumpMemoryLeaks());

    return 0;
}
