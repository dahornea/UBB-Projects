#pragma once
#include "repository.h"

typedef struct{
    Repo* repo;
}Service;

/// Function to create a service
/// \param r The repository
/// \return The service
Service* createService(Repo* r);

/// Function to destroy a service
/// \param s The service we want to destroy
void destroyService(Service* s);

/// Function to add an offer to the service
/// \param s The service
/// \param type The type of the offer
/// \param address The address of the offer
/// \param surface The surface of the offer
/// \param price The price of the offer
/// \return The added offer
int addService(Service* s, char* type, char* address, int surface, int price);

///
/// \param s The service
/// \return The repo of the service
Repo* getRepo(Service* s);

/// Function to remove an offer from the service
/// \param s The service
/// \param address The unique address of the offer
/// \return The service we removed
int removeService(Service* s, char* address);

///
/// \param s
/// \param newType
/// \param address
/// \param newSurface
/// \param newPrice
/// \return
int updateService(Service* s, char* newType, char* address, int newSurface, int newPrice);



///
/// \param o1
/// \param o2
/// \return
int sortAscendingByPrice(Offer* o1, Offer* o2);

///
/// \param o
/// \param surface
/// \return
int filterBySurface(Offer* o, int surface);

///
/// \param o
/// \param type
/// \return
int filterByType(Offer* o, char* type);

///
/// \param result
/// \param sort
void sortVector(Vector* result, int(*sort)(Offer* o1, Offer* o2));

///
/// \param s
/// \param string
/// \param result
/// \return
int filterByString(Service* s, char* string, Vector* result);

///
/// \param s
/// \param type
/// \param surface
/// \param result
/// \return
int filterTypeAndSurface(Service* s, char* type, int surface, Vector* result);