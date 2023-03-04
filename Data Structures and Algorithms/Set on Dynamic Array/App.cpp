#include "Set.h"
#include "SetIterator.h"
#include "ExtendedTest.h"
#include "ShortTest.h"
#include <stack>
#include <iostream>
using namespace std;




int main() {

	testAll();
	testAllExtended();
    Set s;
    s.add(5);
    s.add(10);
    s.add(15);
    SetIterator iterator = s.iterator();
    iterator.first();
    iterator.next();
    iterator.next();
    iterator.previous();
    TElem e = iterator.getCurrent();
    cout<<e<<endl;

	cout << "That's all!" << endl;
	system("pause");

}



