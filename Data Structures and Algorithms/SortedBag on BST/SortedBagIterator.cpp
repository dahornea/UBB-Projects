#include "SortedBagIterator.h"
#include "SortedBag.h"
#include <exception>

using namespace std;

SortedBagIterator::SortedBagIterator(const SortedBag& b) : bag(b) {
	//TODO - Implementation
    first();
}

TComp SortedBagIterator::getCurrent() {
	//TODO - Implementation
	if(!valid())
        throw std::exception();
    return current;
}

bool SortedBagIterator::valid() {
	//TODO - Implementation
	return iterated < bag.size();
}

void SortedBagIterator::next() {
	//TODO - Implementation
    if(!valid())
        throw std::exception();
    iterated++;
    auto stop = false;
    auto count = 0;
    iterateTree(bag.tree, [&](Node* node){
        if(iterated == count){
            current = node->value;
            stop = true;
        }
        count++;
    }, stop);
}

void SortedBagIterator::first() {
	//TODO - Implementation
    iterated = 0;
    auto stop = false;
    auto count = 0;
    iterateTree(bag.tree, [&](Node* &node){
        if(iterated == count){
            current = node->value;
            stop = true;
        }
        count++;
    }, stop);
}

void SortedBagIterator::iterateTree(Node *root, const std::function<void(Node *&)> &action, bool &shouldStop) {
    if(root == nullptr || shouldStop)
        return;
    iterateTree(root->left, action, shouldStop);
    action(root);
    iterateTree(root->right, action, shouldStop);
}
