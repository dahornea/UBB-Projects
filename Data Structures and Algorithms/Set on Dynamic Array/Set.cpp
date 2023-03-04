#include "Set.h"
#include "SetITerator.h"

Set::Set() {
	//TODO - Implementation
    arr_size = 0;
    capacity = 1;
    array = new TElem[1];
}


bool Set::add(TElem elem) {
	//TODO - Implementation
    if(search(elem))
        return false;
    array[arr_size] = elem;
    arr_size++;
    if(arr_size == capacity){
        capacity *= 2;
        auto* temp = new TElem[capacity];
        for(int i = 0; i < arr_size; i++)
            temp[i] = array[i];
        delete[] array;
        array = temp;
    }

    return true;
}
///Best case: O(1) and worst case O(n)


bool Set::remove(TElem elem) {
	//TODO - Implementation
    if(!search(elem))
	    return false;
    bool found = false;
    for (int i = 0; i < arr_size-1; ++i){
        if(array[i] == elem)
            found = true;
        if(found)
            array[i] = array[i+1];
    }
    --arr_size;
    return true;
}
///Best case O(n) and worst case O(n)

bool Set::search(TElem elem) const {
	//TODO - Implementation
    for(int i = 0; i < arr_size; i++){
        if(array[i] == elem)
            return true;
    }
	return false;
}
///Best case: O(1) and worst case: O(n)

int Set::size() const {
	//TODO - Implementation
    return arr_size;

}
/// O(1)

bool Set::isEmpty() const {
	//TODO - Implementation
    if(arr_size == 0)
        return true;
	else
        return false;
}
/// O(1)

Set::~Set() {
	//TODO - Implementation
    delete[] array;
}


SetIterator Set::iterator() const {
	return SetIterator(*this);
}


