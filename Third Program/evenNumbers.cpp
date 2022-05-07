// Finding even numbers in an array!
#include <iostream>
using namespace std;
int main() {
// initialize an array without specifying size
int numbers[] = {7, 5, 6, 12, 35, 27};
cout << "The even numbers are: ";
// print array elements
// use of range-based for loop
for(int i=0; i<6;i++) {
if (numbers[i] % 2 == 0) {
cout << numbers[i] << ", " << endl;
}
}
return 0;
}
