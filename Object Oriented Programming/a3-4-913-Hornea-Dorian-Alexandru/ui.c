#include "ui.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

UI* createUI(Service* s){
    UI* ui = malloc(sizeof(UI));
    if(ui == NULL){
        return NULL;
    }
    ui->s = s;

    return ui;
}

void destroyUI(UI *ui)
{
    if(ui == NULL) {
        return;
    }
    destroyService(ui->s);
    free(ui);
}

void print_menu(){
    printf("\tReal Estate Agency menu:\n");
    printf("To add an offer enter: 1,\n");
    printf("To remove an offer enter: 2,\n");
    printf("To update an offer enter: 3,\n");
    printf("To print all offers enter: 4,\n");
    printf("To print all offers filtered by a string enter: 5.\n");
    printf("To get all offers of a given type, with a surface greater than a given value enter: 6,\n");
    printf("To close this menu enter: 0.\n");
}

int addUI(UI* ui){
    char type[10], address[30];
    int surface, price;
    printf("The offer is for a:");
    scanf_s("%s", &type);
    printf("The offer is located in:");
    scanf_s("%s", &address);
    printf("The offer has a surface of:");
    scanf_s("%d", &surface);
    printf("The offer has a price of:");
    scanf_s("%d", &price);
    return addService(ui->s, type, address, surface, price);

}

int removeUI(UI* ui){
    char address[30];
    printf("The address of the offer is:");
    scanf_s("%s", &address);
    return removeService(ui->s, address);
}

int updateUI(UI* ui) {
    char address[30], newType[10];
    int newSurface, newPrice;

    printf("Address of the offer:");
    scanf_s("%s", &address);

    printf("New type of the offer:");
    scanf_s("%s", &newType);

    printf("New surface of the offer:");
    scanf_s("%d", &newSurface);

    printf("New price of the offer:");
    scanf_s("%d", &newPrice);

    updateService(ui->s, newType, address, newSurface, newPrice);
}

void listAllOffers(UI* ui){
    if(ui == NULL){
        return;
    }
    Repo* repo = getRepo(ui->s);
    if(repo == NULL){
        return;
    }
    if(getLengthRepo(repo) == 0){
        printf("There are no offers.\n");
    }
    else{
        for(int i = 0; i < getLengthRepo(repo); i++){
            Offer* o = getOfferOnPos(repo, i);
            char offer[200];
            toString(o, offer);
            printf("%s\n", offer);
        }
    }
}

int printVector(Vector* result){
    int i;
    for(i = 0; i < result->size; i++){
        char string[300];
        Offer* o = (Offer*)malloc(sizeof(Offer));
        if(o == NULL)
            return 0;

        o = result->data[i];
        toString(o, string);
        if(o != NULL)
            printf("%s\n", string);
        else
            printf("No offer found.\n");
    }
    return 1;
}

int listByString(UI* ui) {
    char string[30];
    int filtered, shown;
    printf("The string you want to search:");
    scanf_s("%s", &string);
    Vector *result = createVector(getLengthRepo(ui->s->repo));
    if (result == NULL)
        return 0;


    filtered = filterByString(ui->s, string, result);
    if (result->size == 0 || filtered == 0)
        return 0;
    shown = printVector(result);
    if (shown == 0)
        return 0;
    destroyVector(result);
    return 1;

}

int listByTypeAndSurface(UI* ui){
    if(ui == NULL)
        return 0;
    char type[10];
    int surface, filtered, printed;

    printf("Enter the type:");
    scanf_s("%s", &type);

    printf("Enter the surface:");
    scanf_s("%d", &surface);

    Vector* result = createVector(getLengthRepo(ui->s->repo));
    if(result == NULL)
        return 0;
    filtered = filterTypeAndSurface(ui->s, type, surface, result);
    if(result->size == 0 || filtered == 0)
        return 0;
    printed = printVector(result);
    if(printed == 0)
        return 0;

    destroyVector(result);
    return 1;

}

int validInput(int input){
    if(input >= 0 && input <= 6) {
        return 1;
    }
    return 0;
}

int readInteger(const char* message){
    char s[16] = { 0 };
    int res = 0;
    int flag = 0;
    int r = 0;

    while(flag == 0){
        printf(message);
        int scanf_result = scanf("%15s", s);

        r = sscanf_s(s, "%d", &res);
        flag = (r == 1);
        if(flag == 0){
            printf("Couldn't read the number.\n");
        }
    }
    return res;
}

void start(UI* ui){
    while(1) {
        print_menu();
        int command = readInteger("Enter the command:");
        while(validInput(command) == 0){
            printf("Please input a valid option.\n");
            command = readInteger("Enter the command:");
        }
        if(command == 0){
            break;
        }
        switch(command){
            case 1:
            {
                int res = addUI(ui);
                if(res == 1){
                    printf("Offer added successfully.\n");
                }
                else{
                    printf("The offer already exists.\n");
                }
                break;
            }
            case 2:
            {
                int res = removeUI(ui);
                if(res == 1)
                    printf("Offer removed successfully.\n");
                else
                    printf("The offer does not exist.");
                break;
            }
            case 3: {
                int res = updateUI(ui);
                if (res == 1)
                    printf("Offer updated successfully.\n");
                else
                    printf("The offer does not exist.");
                break;
            }
            case 4: {
                listAllOffers(ui);
                break;
            }
            case 5:{
                int res = listByString(ui);
                if(res == 1)
                    printf("Offers filtered successfully");
                else
                    printf("Offers couldn't be filtered");
                break;
            }
            case 6: {
                int res = listByTypeAndSurface(ui);
                if(res == 0)
                    printf("Error filtering offers.\n");
                break;
            }
        }
    }
}