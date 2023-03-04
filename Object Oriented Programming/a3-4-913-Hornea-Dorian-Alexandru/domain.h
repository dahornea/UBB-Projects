#pragma once

typedef struct{
    char* type;
    char* address;
    int surface;
    int price;
}Offer;

/// Function for creating an offer
/// \param type The type of the offer
/// \param address The address of the offer
/// \param surface The surface of the offer
/// \param price The price of the offer
/// \return The offer
Offer* createOffer(char* type, char* address, int surface, int price);

/// Function to free the memory that was dynamically allocated
/// \param o The offer we want to "free"
void destroyOffer(Offer* o);

/// Function that returns the type of the offer
/// \param o The offer
/// \return The type of the offer
const char* getType(Offer* o);

///
/// \param o The offer
/// \return The address of the offer
const char* getAddress(Offer* o);

///
/// \param o The offer
/// \return The surface of the offer
int getSurface(Offer* o);

///
/// \param o The offer
/// \return The price of the offer
int getPrice(Offer* o);

/// Function to set the type of the offer
/// \param o The offer
/// \param type The type we want to set
void setType(Offer* o, char* type);

/// Function to set the address of an offer
/// \param o The offer
/// \param address The address we want to set
void setAddress(Offer* o, char* address);

/// Function to set the surface of an offer
/// \param o The offer
/// \param newSurface The surface we want to set
void setSurface(Offer* o, int newSurface);

/// Function to set the price of an offer
/// \param o The offer
/// \param newPrice The price we want to set
void setPrice(Offer* o, int newPrice);

/// Str function for our struct
/// \param o The offer
/// \param str The format in which we'll print an offer
void toString(Offer* o, char str[]);

Offer* copyOffer(Offer* o);

/// Test function
void testOffer();