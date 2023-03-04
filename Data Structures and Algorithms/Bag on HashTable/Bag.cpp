#include "Bag.h"
#include "BagIterator.h"
#include <exception>
#include <iostream>
using namespace std;


Bag::Bag() {
	//TODO - Implementation
    m = 10;
    sizeH = 0;
    table = new Node*[m];
    for(int i = 0; i < m; ++i)
        table[i] = nullptr;
}

/*
 * Best case: Theta(1)
 * Worst case: Theta(3 * m)
 * Overall: O(3*m)
 */
void Bag::add(TElem elem) {
	//TODO - Implementation
    if ((float)sizeH /(float) m >= ALPHA)
        resize(2 * m);
    auto poz = h(elem);
    auto newNode = new Node;
    newNode->value = elem;
    newNode->next = table[poz];
    newNode->frequency = nrOccurrences(elem);
    table[poz] = newNode;
    sizeH++;

}

/*
 * Best case: Theta(1)
 * Worst case: Theta(sizeH)
 * Overall: O(sizeH)
 */
bool Bag::remove(TElem elem) {
	//TODO - Implementation
	if(sizeH == 0)
        return false;
    auto current = table[h(elem)];
    Node* prev = nullptr;
    bool exists = false;
    while(current != nullptr){
        if(current->value == elem) {
            if (prev == nullptr) {
                table[h(elem)] = current->next;
                delete current;
            } else {
                prev->next = current->next;
                delete current;
            }
            sizeH--;
            exists = true;
            break;
        }
        prev = current;
        current = current->next;
    }
    return exists;
}

/*
 * Best case: Theta(1)
 * Worst case: Theta(sizeH)
 * Overall: O(sizeH)
 */
bool Bag::search(TElem elem) const {
	//TODO - Implementation
	if(sizeH == 0){
        return false;
    }
    auto current = table[h(elem)];
    while(current != nullptr){
        if(current->value == elem){
            return true;
        }
        current = current->next;
    }
    return false;
}

/*
 * Best case: Theta(1)
 * Worst case: Theta(size of table(elem))
 * Overall: O(size of table(elem))
 */
int Bag::nrOccurrences(TElem elem) const {
	//TODO - Implementation
	int poz = h(elem);
    auto current = table[poz];
    int occurrences = 0;
    while(current!= nullptr){
        if(current->value == elem){
            occurrences ++;
        }
        current = current->next;
    }
    return occurrences;
}

// O(1)
int Bag::size() const {
	//TODO - Implementation
	return sizeH;
}

// O(1)
bool Bag::isEmpty() const {
	//TODO - Implementation
	return sizeH == 0;
}

BagIterator Bag::iterator() const {
	return BagIterator(*this);
}


Bag::~Bag() {
	//TODO - Implementation
    for(int i = 0; i < m; i++){
        auto current = table[i];
        while(current != nullptr){
            auto prev = current;
            current = current->next;
            delete prev;
        }
    }
    delete[] table;
}

// O(3 * m)
void Bag::resize(int newCap) {
    Node** newArr = new Node*[newCap];
    for(int i = 0; i < newCap; ++i)
        newArr[i] = nullptr;
    auto oldM = m;
    m = newCap;
    for(int i = 0; i < oldM; ++i){
        auto current = table[i];
        while(current != nullptr){
            auto prev = current;
            auto poz = h(current->value);
            Node* newNode = new Node;
            newNode->next = newArr[poz];
            newNode->value = current->value;
            newNode->frequency = current->frequency;
            newArr[poz] = newNode;
            current = current->next;
            delete prev;
        }
    }
    delete[] table;
    table = newArr;
}

int Bag::h(TElem elem) const {
    return abs(elem % m);
}
