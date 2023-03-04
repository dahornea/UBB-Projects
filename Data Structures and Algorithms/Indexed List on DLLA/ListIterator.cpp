#include "ListIterator.h"
#include "IndexedList.h"
#include <exception>

ListIterator::ListIterator(const IndexedList& list) : list(list){
   //TODO - Implementation
    current_index = list.head;
}

void ListIterator::first(){
    //TODO - Implementation
    current_index = list.head;
}

void ListIterator::next(){
    //TODO - Implementation
    if(current_index < 0 || current_index >= list.cap){
        throw std::exception();
    }
    current_index = list.next[current_index];
}

void ListIterator::previous() {
    if(current_index == list.head)
        throw std::exception();
    current_index = list.next[current_index-2];
}

bool ListIterator::valid() const{
    //TODO - Implementation
    return current_index >= 0 && current_index < list.cap;
}

TElem ListIterator::getCurrent() const{
   //TODO - Implementation
    if(valid()){
        return list.elems[current_index];
    }else {
        throw std::exception();
    }
}