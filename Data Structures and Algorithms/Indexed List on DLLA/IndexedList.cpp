#include <exception>

#include "IndexedList.h"
#include "ListIterator.h"

IndexedList::IndexedList() {
	//TODO - Implementation
    this->cap = 100;
    this->elems = new TElem[this->cap];
    this->next = new int[this->cap];
    for (int i = 0; i < this->cap - 1; i++)
        this->next[i] = i + 1;
    this->next[this->cap - 1] = -1;
    this->firstEmpty = 0;
    this->length = 0;
    this->head = -1;
}
//Complexity: Theta(1)
int IndexedList::size() const {
    //TODO - Implementation
    return this->length;
}

//Complexity: Theta(1)
bool IndexedList::isEmpty() const {
    //TODO - Implementation
    if (this->length == 0 && this->head == -1)
        return true;
    return false;
}
/*
 * Best case: theta(1)
 * Worst case: theta(length)
 * Overall: O(length)
 */
TElem IndexedList::getElement(int pos) const {
    //TODO - Implementation
    if(pos < 0 || pos >= length){
        throw std::exception();
    }
    if(head < 0 || head >= cap){
        throw std::exception();
    }
    int current = head;
    for(int i=0; i<pos; i++){
        current = next[current];
        if(current < 0 || current >= cap){
            throw std::exception();
        }
    }
    return elems[current];
}

/*
 * Best case: theta(1)
 * Worst case: theta(length)
 * Overall: O(length)
 */
TElem IndexedList::setElement(int pos, TElem e) {
    //TODO - Implementation
    if(pos < 0 || pos >= length){
        throw std::exception();
    }
    //if(head < 0 || head >= cap){
     //   throw std::exception();
   // }
    int current = head;
    for(int i=0; i<pos; i++){
        current = next[current];
        if(current < 0 || current >= cap){
            throw std::exception();
        }
    }
    TElem old = elems[current];
    elems[current] = e;
    return old;
}

/*
 * Best case: theta(1)
 * Worst case: theta(3*cap + length)
 * Overall: O(2*cap + length)
 */
void IndexedList::addToEnd(TElem e) {
    //TODO - Implementation
    addToPosition(length, e);
}

/*
 * Best case: theta(1)
 * Worst case: theta(cap + length)
 * Overall: O(cap + length)
 */
void IndexedList::addToPosition(int pos, TElem e) {
    //TODO - Implementation
    if(pos < 0 || pos > length) {
        throw std::exception();
    }
    if(firstEmpty == -1){
        TElem* newElems = new TElem[2 * cap];
        int* newNext = new int[2 * cap];
        for(int i=0; i<cap; i++){
            newElems[i] = elems[i];
            newNext[i] = next[i];
        }
        for(int i=cap; i<2*cap-1; i++){
            newNext[i] = i + 1;
        }
        newNext[2 * cap - 1] = -1;
        delete[] elems;
        delete[] next;
        elems = newElems;
        next = newNext;
        firstEmpty = cap;
        cap = 2 * cap;
    }
    int newPosition = firstEmpty;
    firstEmpty = next[firstEmpty];
    elems[newPosition] = e;
    length++;
    //set the pointers
    if(pos == 0){
        next[newPosition] = head;
        head = newPosition;
    }else{
        int current = head;
        for(int i=0; i<pos-1; i++){
            current = next[current];
            if(current < 0 || current >= cap){
                throw std::exception();
            }
        }
        next[newPosition] = next[current];
        next[current] = newPosition;
    }
}

/*
 * Best case: theta(1)
 * Worst case: theta(length)
 * Overall: O(length)
 */
TElem IndexedList::remove(int pos) {
    //TODO - Implementation
    if (pos < 0 || pos >= length) {
        throw std::exception();
    }
    int crtNode = head;
    int prevNode = -1;
    for(int i=0; i<pos; i++){
        prevNode = crtNode;
        crtNode = next[crtNode];
        if(crtNode == -1){
            throw std::exception();
        }
    }

    if(crtNode == head){
        head = next[head];
    }else{
        next[prevNode] = next[crtNode];
    }
    next[crtNode] = firstEmpty;
    firstEmpty = crtNode;
    length--;

    return elems[crtNode];
}

/*
 * Best case: theta(1)
 * Worst case: theta(length)
 * Overall: O(length)
 */
int IndexedList::search(TElem e) const{
    //TODO - Implementation
    int current = head;
    for(int i=0; i<length; i++){
        if(current == -1){
            throw std::exception();
        }
        if(elems[current] == e){
            return i;
        }
        current = next[current];
    }
    return -1;
}

ListIterator IndexedList::iterator() const {
    return ListIterator(*this);        
}

IndexedList::~IndexedList() {
	//TODO - Implementation
    delete[] elems;
}