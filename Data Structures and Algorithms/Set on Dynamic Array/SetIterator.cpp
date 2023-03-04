#include "SetIterator.h"
#include "Set.h"
#include <exception>

SetIterator::SetIterator(const Set& m) : set(m)
{
	//TODO - Implementation
    pos = 0;
}


void SetIterator::first() {
	//TODO - Implementation
    pos = 0;
}
/// O(1)

void SetIterator::next() {
	//TODO - Implementation
    if (pos >= set.arr_size)
        throw std::exception();
    pos++;
}
/// O(1)

void SetIterator::previous(){
    if(pos <= set.arr_size)

    pos--;
}
/// O(1)

TElem SetIterator::getCurrent()
{
	//TODO - Implementation
    if(pos >= set.arr_size)
	    return NULL_TELEM;
    return set.array[pos];
}
/// O(1)

bool SetIterator::valid() const {
	//TODO - Implementation
    if(pos >= set.arr_size)
	    return false;
    else
        return true;
}
///O(1)



