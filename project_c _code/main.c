#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <conio.h>
#include <string.h>
// *********** Selection Sort ***********************
void SelectionSortNum (int A[],int n){
  int i,j,temp,min;
  for (i=0;i<n-1;i++){
    min=i;
    for(j=i+1;j<n;j++){
      if (A[j]<A[min])
          min=j;
    }
    temp=A[i];
    A[i]=A[min];
    A[min]=temp;
  }
}
// Function swapping two characters
void swapchar_for_selection(char *pc1, char *pc2)
{
    char tempc = *pc1;
    *pc1 = *pc2;
    *pc2 = tempc;
}
// Function for sorting characters
void SelectionSort_Char (char str[], int num){
  int i,j;
  for (i=0;i<num;i++){
    for (j=i+1;j<num;j++){
      if (str [j] < str [i]){
        swapchar_for_selection(&str[i],&str[j]);

      }
    }
  }
}
void swapint_for_selection(int *pi1, int *pi2)
{
	int tempi = *pi1;
	*pi1 = *pi2;
	*pi2 = tempi;
}
// Function swapping two characters
// Print Integer Array
/*void printintArray(int arr[], int s)
{
	int i;
	for (i=0; i < s; i++)
		printf("%d ", arr[i]);
	printf("\n");
}*/
// Print Character Array
/*void printcharArray(char arr[], int s)
{
	int i;
	for (i=0; i < s; i++)
		printf("%c ", arr[i]);
	printf("\n");
}*/
// *********** Bubble Sort **************************
void swapint_for_bubble_sort(int *pi1, int *pi2)
{
	int tempi = *pi1;
	*pi1 = *pi2;
	*pi2 = tempi;
}
// Function swapping two characters
void swapchar_for_bubble_sort(char *pc1, char *pc2)
{
    char tempc = *pc1;
    *pc1 = *pc2;
    *pc2 = tempc;
}

// Function Implementing Bubble Sort Algorithms for Integers
void BubbleSort_int(int arr[], int n)
{
int i, j;
bool is_swapped;
for (i = 0; i < n-1; i++)
{
	is_swapped = false;
	for (j = 0; j < n-i-1; j++)
	{
		if (arr[j] > arr[j+1])
		{
		swapint_for_bubble_sort(&arr[j], &arr[j+1]);
		is_swapped = true;
		}
	}
	if (is_swapped == false)
		break;
}
}
// Function Implementing Bubble Sort Algorithms for Characters
void BubbleSort_char(char arr[], int n)
{
int i, j;
bool is_swapped;
for (i = 0; i < n-1; i++)
{
	is_swapped = false;
	for (j = 0; j < n-i-1; j++)
	{
		if ((int)(arr[j]) > (int)(arr[j+1]))
		{
		swapchar_for_bubble_sort(&arr[j], &arr[j+1]);
		is_swapped = true;
		}
	}
	if (is_swapped == false)
		break;
}
}
//*************Merge Sort ********************
int merge_int(int arr[], int left_index, int middle_index, int right_index) {
	//Initialize left and right arrays based on the number of elements that were passed on.
	int left_size = middle_index - left_index + 1;

	int right_size = right_index - middle_index;

	int L[left_size], R[right_size];

	//Copy the left elements to L from arr
	int i;
	for(i = 0; i < left_size; i++) {
		L[i] = arr[left_index + i];
	}
	//Copy the right elements to R from arr
	for(i = 0; i < right_size; i++) {
		R[i] = arr[middle_index + 1 + i];
	}

	int L_ptr = 0, R_ptr = 0, arr_ptr = left_index;

	while((L_ptr < left_size) && (R_ptr < right_size)) {

		if(L[L_ptr] > R[R_ptr]) {

			arr[arr_ptr] = R[R_ptr];
			R_ptr++;
		}

		else {
			arr[arr_ptr] = L[L_ptr];
			L_ptr++;
		}
		arr_ptr++;
	}

	//Copy the remaining left elements
	for(i = L_ptr; i < left_size; i++) {
		arr[arr_ptr] = L[i];
		arr_ptr++;
	}

	//Copy the remaining right elements
	for(i = R_ptr; i < right_size; i++) {
		arr[arr_ptr] = R[i];
		arr_ptr++;
	}
	return 1;
}

int mergeSort_int(int arr[], int left_index, int right_index) {
	if(left_index < right_index) {
		//Find the middle point to divide the array into half
		int middle_index = (left_index + right_index) / 2;

		//Call merge sort for first half
		mergeSort_int(arr, left_index, middle_index);

		//Call merge sort for second half
		mergeSort_int(arr, middle_index+1, right_index);

		//Call the two halves to merge:
		merge_int(arr, left_index, middle_index, right_index);
	}
}
void merge_char(char * arr, int l, int m, int r)
{
    //creating i and j to be the indexes of temporary arrays while k is the index of the merge array
	int i, j, k;
	//initializing size of the two temporary arrays
	int S1 = m - l + 1;
	int S2 = r - m;
    //creating the two temporary arrays L for left side and R for right side
	char L[S1], R[S2];

	// Copy data to temp arrays L[] and R[]
	for (i = 0; i < S1; i++)
		L[i] = arr[l + i];
	for (j = 0; j < S2; j++)
		R[j] = arr[m + 1 + j];



	i = 0; // Initial index of L[] array
	j = 0; // Initial index of R[] array
	k = l; // Initial index of merge array to start from left side
	while (i < S1 && j < S2) {
		if (L[i] <= R[j]) {
			arr[k] = L[i];
			i++;
		}
		else {
			arr[k] = R[j];
			j++;
		}
		k++;
	}

	/* Copy the remaining elements of L[], if there
	are any */
	while (i < S1) {
		arr[k] = L[i];
		i++;
		k++;
	}

	/* Copy the remaining elements of R[], if there
	are any */
	while (j < S2) {
		arr[k] = R[j];
		j++;
		k++;
	}
}
// recursion array to divide and conquer array of characters to be sorted
void mergeSort_char(char * arr, int l, int r)
{
	if (l < r) {
        //to avoid over flow of the array
		int m = l + (r - l) / 2;
		// Sort first and second halves
		mergeSort_char(arr, l, m);
		mergeSort_char(arr, m + 1, r);
		merge_char(arr, l, m, r);
	}
}
// **************************** binary search ****************************

int binarySearch(int arr[], int l, int r, int x)
{
	while (l <= r) {
		int m = l + (r - l) / 2;

		// Check if x is present at mid
		if (arr[m] == x)
			return m;

		// If x greater, ignore left half
		if (arr[m] < x)
			l = m + 1;

		// If x is smaller, ignore right half
		else
			r = m - 1;
	}

	// if we reach here, then element was
	// not present
	return -1;
}
// *********************** binary search characters ************
 int binarySearch_ch(char arr[], char x,int n)
    {
        int l = 0 ;
        int r = n - 1;
        while (l <= r)
        {
            int m = l + (r - l) / 2;

        int res;
        if (x == (arr[m]))
            res = 0;


            // Check if x is present at mid
            if (res == 0)
                return m;

            // If x greater, ignore left half
            if (x > (arr[m]))
                l = m + 1;

            // If x is smaller, ignore right half
            else
                r = m - 1;
        }

        return -1;
    }
//***************************************************************

int main()
{
    int size,n,type,i,n_search;
    int result;
    printf("Choose 1 for Bubble sort , 2 for selection sort , 3 for merge sort \n");
    scanf("%d",&n);
    printf("Choose 1 for Character, 2 for number \n");
    scanf("%d",&type);
    printf("Enter the size of array : ");
    scanf("%d",&size);
    int arr_int[size];
    char arr_char[size];
    char char_search;
    switch(type){
        case 1:
                printf("Enter Characters you want to sort in string: ");
                scanf("%s",&arr_char);

            switch(n){
                case 1:
                    BubbleSort_char(arr_char,size);
                    break;
                case 2:
                    SelectionSort_Char (arr_char, size);
                    break;
                case 3:
                    mergeSort_char(arr_char,0,size-1);
                    break;

            }
            printf("Sorted array is: \t");
            for (i=0;i<size;i++){
            printf("%c \t",arr_char[i]);
            }

            printf("\nEnter character to search: ");
            scanf(" %c",&char_search);
            //int s = sizeof(arr_char) / sizeof(arr_char[0]);
            result = binarySearch_ch(arr_char,char_search,size);
            (result == -1) ? printf("Element is not present" " in array"): printf("Element is present at ""index %d",result);
            break;

        case 2:
            for (i=0;i<size;i++){
                printf("Enter numbers you want to sort: ");
                scanf("%d",&arr_int[i]);
                }
        switch(n){
            case 1:
                BubbleSort_int(arr_int,size);
                break;
            case 2:
                SelectionSortNum(arr_int,size);
                break;
            case 3:
                mergeSort_int(arr_int,0,size-1);
                break;

        }
        printf("Sorted array is: \t");
            for (i=0;i<size;i++){
                printf("%d \t",arr_int[i]);
            }
        printf("\nEnter number to search: ");
        scanf("%d",&n_search);
        int n = sizeof(arr_int) / sizeof(arr_int[0]);
        result = binarySearch(arr_int, 0, n - 1, n_search);
        (result == -1) ? printf("Element is not present" " in array"): printf("Element is present at ""index %d",result);

        break;
    }


    return 0;
}

