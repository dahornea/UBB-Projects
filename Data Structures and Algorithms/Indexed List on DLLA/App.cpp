#include <iostream>
#include <assert.h>
#include "ShortTest.h"
#include "ExtendedTest.h"
#include "IndexedList.h"
#include "ListIterator.h"
using namespace std;

int main(){
    IndexedList list = IndexedList();
    ListIterator it = list.iterator();
    list.addToPosition(0, 1);
    list.addToPosition(1, 2);
    list.addToPosition(2, 3);
    it.first();
    it.next();
    it.next();
    it.previous();
    assert(it.getCurrent() == 2);
    cout<<"Lab work test done"<<endl;
    testAll();
    testAllExtended();
    cout<<"Finished LI Tests!"<<endl;
}