#include "Bag.h"
#include "ShortTest.h"
#include "ExtendedTest.h"
#include "BagIterator.h"
#include "assert.h"
#include <iostream>

using namespace std;

int main() {
    Bag b;
    BagIterator it = b.iterator();
    b.add(5);
    b.add(1);
    b.add(10);
    b.add(7);
    it.first();
    it.next();
    it.next();
    it.previous();
    assert(it.getCurrent() == 1);
    cout<< "Lab work test done"<<endl;
	testAll();
	cout << "Short tests over" << endl;
	testAllExtended();

	cout << "All test over" << endl;
}