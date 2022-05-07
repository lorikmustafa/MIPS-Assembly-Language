// A C++ program to demonstrate working of
// recursion
#include <iostream>


using namespace std;
void printFun(int test)
{
	if (test < 1)
		return;
	else {
		cout<< test << " ";
		printFun(test - 1); // statement 2
		cout << test << " ";
		return;
	}
}
// Driver Code
int main()
{
	int test = 4;
	printFun(test);
}
