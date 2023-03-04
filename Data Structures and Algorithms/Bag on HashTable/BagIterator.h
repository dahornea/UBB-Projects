#include "Bag.h"

class BagIterator
{
	//DO NOT CHANGE THIS PART
	friend class Bag;
	
private:
	const Bag& bag;
	//TODO  - Representation
    int currentKey;
    Bag::Node* currentVal;

	BagIterator(const Bag& c);
public:
	void first();
    void previous();
	void next();
	TElem getCurrent() const;
	bool valid() const;
};
