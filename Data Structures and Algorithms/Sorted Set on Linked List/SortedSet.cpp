#include "SortedSet.h"
#include "SortedSetIterator.h"
#include <iostream>
#include <exception>
using namespace std;

SortedSet::SortedSet(Relation r) {
	//TODO - Implementation
    this->relation = r;
    this->length = 0;
    this->head = nullptr;
    this->tail = nullptr;
}

/*
 * Best case:O(1)
 * Worst case:O(capacity)
 */
bool SortedSet::add(TComp elem) {
	//TODO - Implementation
    if(search(elem))
        return false;
    if(this->length == 0){
        Node* newNode = new Node();
        newNode->info = elem;
        newNode->next = nullptr;
        newNode->prev = nullptr;
        this->head = newNode;
        this->tail = newNode;
        this->length++;
    }
    else{
        Node* currentNode = this->head;
        while(currentNode != nullptr && this->relation(currentNode->info, elem))
            currentNode = currentNode->next;

        if(currentNode == this->head && currentNode != nullptr){
            Node* newNode = new Node();
            newNode->info = elem;
            newNode->prev = nullptr;
            newNode->next = currentNode;
            currentNode->prev = newNode;
            this->head = newNode;
            this->length++;
        }
        else if(currentNode == nullptr){
            Node* newNode = new Node();
            newNode->info = elem;
            newNode->next = currentNode;
            newNode->prev = this->tail;
            this->tail->next = newNode;
            this->tail = newNode;
            this->length++;
        }
        else{
            Node *newNode = new Node();
            newNode->info = elem;
            newNode->prev = currentNode->prev;
            newNode->next = currentNode;
            currentNode->prev->next = newNode;
            currentNode->prev = newNode;
            this->length++;
        }
    }
    return true;
}

/*
 * Best case: O(1)
 * Worst case: O(capacity)
 */
bool SortedSet::remove(TComp elem) {
	//TODO - Implementation
    if(!search(elem))
        return false;
    Node* currentNode = this->head;
    TComp nodeValue;
    int index = 0;
    if(this->length == 0)
        return false;
    else{
      while(index < length){
          nodeValue = currentNode->info;
          if(nodeValue == elem)
              break;
          else {
              currentNode = currentNode->next;
              index++;
          }
      }
      this->length--;
      if(currentNode == this->head)
          this->head = currentNode->next;
      if(currentNode->next != nullptr)
          currentNode->next->prev = currentNode->prev;
      if(currentNode->prev != nullptr)
          currentNode->prev->next = currentNode->next;
      delete currentNode;
    }


    return true;
}


/*
 * Best case:Theta(1)
 * Worst case: Theta(size)
 * Overall: O(size)
 */
bool SortedSet::search(TComp elem) const {
	//TODO - Implementation
    Node* currentNode = this->head;
    while(currentNode != nullptr && this->relation(currentNode->info, elem)){
        if(currentNode->info == elem)
            return true;
        else{
            currentNode = currentNode->next;
        }
    }
	return false;
}

/*
 * O(1)
 */
int SortedSet::size() const {
	//TODO - Implementation
	return this->length;
}


/*
 * O(1)
 */
bool SortedSet::isEmpty() const {
	//TODO - Implementation
    if(this->length == 0)
        return true;
	return false;
}

/*
 * Theta(size(this) * size(S) * size(this))
 */
void SortedSet::intersection(const SortedSet &S) {
    TComp nodevalueI;
    Node *currentNodeI = this->head;
    for(int i = 0; i < this->length; i++) {
        nodevalueI = currentNodeI->info;
        if(!S.search(nodevalueI))
            this->remove(nodevalueI);
        currentNodeI = currentNodeI->next;
    }
}

SortedSetIterator SortedSet::iterator() const {
	return SortedSetIterator(*this);
}


SortedSet::~SortedSet() {
	//TODO - Implementation
    Node* prevNode = nullptr;
    Node* currentNode = this->head;
    while (currentNode != nullptr){
        prevNode = currentNode;
        currentNode = currentNode->next;
        delete prevNode;
    }
}


