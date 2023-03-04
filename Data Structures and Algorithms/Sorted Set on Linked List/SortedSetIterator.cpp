#include "SortedSetIterator.h"
#include <exception>

using namespace std;

SortedSetIterator::SortedSetIterator(const SortedSet& m) : multime(m)
{
	//TODO - Implementation
    this->currentNode = m.head;
}

/*
 * O(1)
 */
void SortedSetIterator::first() {
	//TODO - Implementation
    this->currentNode = this->multime.head;
}

/*
 * o(1)
 */
void SortedSetIterator::next() {
	//TODO - Implementation
    if(this->currentNode != nullptr)
        this->currentNode = this->currentNode->next;
    else{
        throw exception();
    }
}

/*
 * O(1)
 */
TElem SortedSetIterator::getCurrent()
{
	//TODO - Implementation
    if(this->currentNode == nullptr)
	    throw std::exception();
    return this->currentNode->info;
}

/*
 * O(1)
 */
bool SortedSetIterator::valid() const {
	//TODO - Implementation
    if(this->currentNode == nullptr)
	    return false;
    return true;
}

