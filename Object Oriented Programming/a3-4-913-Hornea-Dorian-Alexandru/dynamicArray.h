#pragma once
#include "domain.h"

typedef Offer TElem;

typedef struct{
    TElem** data;
    int size, capacity;
}Vector;

/// Function to create a vector
/// \param capacity The capacity of the vector
/// \return The new vector
Vector* createVector(int capacity);

/// Function to deallocate memory assigned for the vector
/// \param v The vector
void destroyVector(Vector* v);

/// Function to increase the capacity of the vector
/// \param v The vector
void resize(Vector* v);

/// Function to add an element to the vector
/// \param v The vector
/// \param el The element we want to add
void addToVector(Vector* v, TElem* el);

/// Function to remove an element from the vector
/// \param v The vector
/// \param pos The position of the element we want to remove
void removeFromVector(Vector* v, int pos);

/// Fuction to get an element from the vector
/// \param v The vector
/// \param pos The position of the element we want to get
/// \return The element from that position
TElem* get(Vector* v, int pos);

/// Fuction to create a copy of the vector
/// \param v The vector
/// \return The copy of the vector
Vector* makeCopy(Vector* v);

/// Test function for the vector
void testVector();