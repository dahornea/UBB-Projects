#pragma once
#include "IndexedList.h"


class ListIterator{
    //DO NOT CHANGE THIS PART
	friend class IndexedList;
private:
	const IndexedList& list;
	//TODO - Representation
		
    ListIterator(const IndexedList& lista);
    TElem current_index;
public:
    void previous();
    void first();
    void next();
    bool valid() const;
    TElem getCurrent() const;

};

