#pragma once
#include "domain.h"
#include "dynamicArray.h"


typedef struct{
   Vector* vector;
}Repo;

///
/// \return
Repo* createRepo();

/// Function to free the memory
/// \param r The repository
void destroyRepo(Repo* r);

/// This function check if 2 offers have the same address
/// \param o1 First offer
/// \param o2 Second Offer
/// \return 1 if they have the same address, 0 otherwise
int existingId(Offer* o1, Offer* o2);

/// Function to get the length of the repo
/// \param r The repository
/// \return The length
int getLengthRepo(Repo* r);

/// Function to swap 2 offers
/// \param x First offer
/// \param y Second offer
void swapOffers(Offer* x, Offer* y);

/// Function to get the offer from a certain position
/// \param r The repository
/// \param pos The position
/// \return The product from pos
Offer* getOfferOnPos(Repo* r, int pos);

/// Function to get the position of an offer in the repository
/// \param r The repository
/// \param o The offer
/// \return The position on which we can find the offer in the repo
int getPosOfOffer(Repo* r, Offer* o);

/// Function to find an offer by it's address
/// \param r The repository
/// \param address The unique address
/// \return 1 if it finds an offer, 0 otherwise
Offer* findByID(Repo* r, char* address);

/// Function to add an offer to the repo
/// \param r The repository
/// \param o The offer
/// \return 1 if the offer was added, 0 otherwise
int addRepo(Repo* r, Offer* o);

/// Function to remove an offer from the repo if it exists
/// \param r The repository
/// \param address The unique address
/// \return 1 if the product is removed, 0 otherwise
int removeRepo(Repo* r, char* address);

/// Function to update a repo
/// \param r The repo
/// \param newType The new type of the offer
/// \param address The address of the offer
/// \param newSurface The new surface of the offer
/// \param newPrice The new price of the offer
/// \return 1 if the offer was updated successfully, 0 otherwise
int updateRepo(Repo* r, char* newType, char* address, int newSurface, int newPrice);

/// Function to initialize the test repo
/// \param r
void initOfferRepoTest(Repo* r);

/// Function to test the add function
void testAdd();

///Function to test the remove function
void testRemove();

///Function to test the update function
void testUpdate();

/// Function for all tests
void testRepo();