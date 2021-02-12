.data

array: .space 1000                                           #reserve 25 words in memory for array
arr:.space 1000
size: .asciiz "Please enter the size of the array: "        # the message for asking the user to enter the size of the array
enter_char: .asciiz "\nEnter character: "                     # the message displayed when asking the user to enter a character for the array
final: .asciiz "\nThe Sorted array using Bubble Sort is: "  # printing the sorted array after sorting
space: .asciiz " "


message: .asciiz "Enter string \n"
 newline: .asciiz "\n\n"
given: .asciiz "given array is \n"
sorted: .asciiz "Sorted array using Merge sort is "
leftarray: .space 50
rightarray: .space 50
sortchoosing: .asciiz "Enter \n\n1 for bubble sort, \n\n2 for merge sort \n\n3 selection sort\n\n"
arraySize: .word 10


enterAsStr:.asciiz "enter as string :  "  
  comma:  .asciiz ","    
                .align 4  # align 1 byte in memory
                
   msg1:   .asciiz "The Sorted list is:"
            .align 4
            
            
            
  ssearsh:.asciiz "\nsearch:     "
found_mess: .asciiz "found it \n"
notfound_mess: .asciiz "not found it \n"
line:.asciiz "\n\n"

#-------------------------------------------------


enter_int: .asciiz "Enter integer: "                        # the message displayed when asking the user to enter an integer for the array





searchnum:.asciiz "enter a number for search :  "
chooseSortType:.asciiz "1- bubbel sort \n\n 2-merge sort\n\n 3-selected sort \n\n "



Sorted_Array:	.asciiz		"Sorted Array:  "

Bracket:	.asciiz		" "
c: 	.word 100 #int c[100] is global
intorCharcode:.asciiz		"\n\n 1-int\n\n2-char\n\n "
.text


main:

la $a0,intorCharcode
li $v0,4

syscall 


li $v0,5
syscall 

move $s1,$v0
beq $s1,1,intCode

beq  $s1,2,charCode


li $v0,10                                                   # call service 10 to exit the program
syscall 
























#____________________________________________________________________#

#int code


intCode:                                                       # start of the int_code procedure


j sorts

j exiteee


sorts:
        
  
  
  
  
  
  
  
  
  
  
  
  
  
  
# print to ask user to enter the size of the array
la $a0,size                                                 # Load message to print size to $a0 to be able to print it
li $v0,4                                                    # call service 4 to print a String to the screen
syscall                                                     # tell system to do it

li $v0,5                                                    # call service 5 to read an integer and store it in $v0
syscall                                                     # ask the system to prompt an integer
sw $v0,  arraySize
move $s1, $v0                                               # move the size value to register $s1
sub $s1,$s1,1                                               # size = size - 1

addint:                                                     # start of addint function 

la $a0,enter_int                                            # print the message to ask the user to enter an integer
li $v0,4                                                    # call service 4 to print a string
syscall

li $v0,5                                                    # read an integer from the user
syscall

move $t3,$v0                                                # move the integer into $t3
add $t1,$zero,$zero                                         # make $t1 = 0
sll $t1,$t0,2                                               # shift the number 2 places left which means $t1 = $t0 * 4

sw $t3,array ( $t1 )                                        # store the value of $t3 (our int) to the array of address starting from adress of the first element + $t1
addi $t0,$t0,1                                              # $t0 = $t0 + 1
slt $t1,$s1,$t0                                             # $t1 is 1 if $s1(size-1) < $t0(counter) and continue the next instructions
beq $t1,$zero,addint                                        # else if $s1 >= $t0 then $t1 = 0 and apply the loop again

                              # load the array size to $a1 (argument 1)
la $a0,chooseSortType                                                 # Load message to print size to $a0 to be able to print it
li $v0,4                                                    # call service 4 to print a String to the screen
syscall    
li $v0, 5
  syscall

move $t9,$v0
beq $t9,1,bubble
   beq $t9,3,MAIN
  j  merge




bubble:

la $a0,array                                                #load the pointer of array to $a0 (argument 0)
addi $a1,$s1,1     
jal bubble_sort                                             # set the $ra (program counter) then go to the bubble_sort function

la $a0,final                                                # after sorting the array we load the message final to be printed to the user
li $v0,4                                                    # service 4 for printing a string
syscall

la $t0,array                                                # load the address of the array to t0 
li $t1,0                                                    # $t1 = 0

print:
lw $a0,0($t0)                                               # load the item in $t0 address to $a0
li $v0,1                                                    # call service 1 to print an integer
syscall                                                     # print the integer we choose

la $a0,space                                                # print a space between each integer
li $v0,4                                                    #service 4 to print a string
syscall

addi $t0,$t0,4                                              # $t0 = $t0 + 4
addi $t1,$t1,1                                              # t1 = t1 + 1
slt $t2,$s1,$t1                                             # if $s1 (size) < $t1 set $t2 = 1 and break
beq $t2,$zero,print                                         # else $t2 = 0 and print again
j binarySearch
li $v0,10                                                   # call service 10 to exit the program
syscall                                         

# function for sorting the array using Bubble sort Algorithm
bubble_sort:
li $t0,0                                                    # set $t0 to 0                     

loop1:

addi $t0,$t0,1                                              #set counter to 1
bgt $t0,$a1,end                                             # if the counter > array size then break and go to end        
add $t1,$a1,$zero                                           # $t1 = size 

loop2:

bge $t0,$t1,loop1                                           # if counter >= $t1(size) then break and go to loop 1

subi $t1,$t1,1                                              # t1(initially the size) = t1 - 1

sll $t4, $t1, 2                                             # $t4 = $t1 (size - 1) * 4 --> shifting left by 2
subi $t3, $t4, 4                                            # $t3 = $t4 - 4                 

add $t4,$t4,$a0                                             # we add the array address and t4 and store it in t4
add $t3,$t3,$a0                                             # we add the array address and t3 and store it in t3
lw $t5,0($t4)                                               # we load the integer which is in $t4 address and store it in $t5 
lw $t6,0($t3)                                               #we load the integer in $t3 address (the element before the above one) and store it in $t6 

swap:
bgt $t5,$t6,loop2                                           #if the item in $t5 > the one in $t6 we return to the loop for the next round
sw $t5,0($t3)                                               #else we swap the two integers, we  replace the item in $t5 by the item in $t3 address
sw $t6,0($t4)                                               # and we replace the itme in $t6 by the item in $t4 address
j loop2                                                     #we finish this loop round 

end:

jr $ra                                                     #return to the last place stored in the program counter


  binarySearch:
   li $v0, 4
  la $a0, line
  syscall
   li $v0, 4
  la $a0, searchnum
  syscall
  li $v0, 5
  syscall
  move $t0,$v0 # find x =$t0
  lw $t9,arraySize
  add $t1,$zero,$t9 # Right side
  
  addi $t2,$zero,0 # left side
  
  addi $t3,$zero,0 # mid
    addi $t4,$zero,0 
  loop:
  add $t3,$t2,$t1
  div $t3,$t3,2
  
  mul $t4,$t3,4
 
  lw $t5,array($t4)
  beq $t5,$t0,Found
  slt $t6,$t5,$t0
  beq $t6,1,greatleft
  add $t1,$t1,-1
   
   j fi
  greatleft:
  add $t2,$t2,1
  fi:
  slt $s1,$t1,$t2
  beq $s1,1,notFound
  j loop
  Found:
  li $v0, 4
  la $a0, found_mess
  syscall
  
  li $v0, 1
  move $a0, $t3
  syscall
  

li $v0,10                                                   # call service 10 to exit the program
syscall   
  notFound:
  
 li $v0, 4
  la $a0, notfound_mess
  syscall

li $v0,10                                                   # call service 10 to exit the program
syscall   

  


merge:


	la $a0, array		# load address of array to $a0 as an argument
	addi $a1, $zero, 0 	# $a1 = low	
	add $a2, $zero, $s1	# $a2 = high
	jal Mergesort		# Go to MergeSort 
	la  $a0, Sorted_Array	# Print prompt: "Sorted Array: ["
	li  $v0, 4		# MIPS call for printing prompts
	syscall     		
	jal Print		# Go to Print to print the sorted array
	la  $a0, Bracket	# Prints the closing bracket for the array
	li  $v0, 4		# MIPS call for printing prompts
	syscall

	li  $v0, 10		# Done!
	syscall
	
Mergesort: 
	slt $t0, $a1, $a2 	# if low < high then $t0 = 1 else $t0 = 0  
	beq $t0, $zero, Return	# if $t0 = 0, go to Return
	
	addi, $sp, $sp, -16 	# Make space on stack for 4 items
	sw, $ra, 12($sp)	# save return address
	sw, $a1, 8($sp)	       	# save value of low in $a1
	sw, $a2, 4($sp)        	# save value of high in $a2

	add $s0, $a1, $a2	# mid = low + high
	sra $s0, $s0, 1		# mid = (low + high) / 2
	sw $s0, 0($sp) 		# save value of mid in $s0
				
	add $a2, $s0, $zero 	# make high = mid to sort the first half of array
	jal Mergesort		# recursive call to MergeSort
	
	lw $s0, 0($sp)		# load value of mid that's saved in stack 
	addi $s1, $s0, 1	# store value of mid + 1 in $s1
	add $a1, $s1, $zero 	# make low = mid + 1 to sort the second half of array
	lw $a2, 4($sp) 		# load value of high that's saved in stack
	jal Mergesort 		# recursive call to MergeSort
	
	lw, $a1, 8($sp) 	# load value of low that's saved in stack
	lw, $a2, 4($sp)  	# load value of high that's saved in stack
	lw, $a3, 0($sp) 	# load value of mid that's saved in stack and pass it to $a3 as an argument for Merge
	jal Merge		# Go to Merge 	
				
	lw $ra, 12($sp)		# restore $ra from the stack
	addi $sp, $sp, 16 	# restore stack pointer
	jr  $ra

Return:
	jr $ra 			# return to calling routine
	
Merge:
	add  $s0, $a1, $zero 	# $s0 = i; i = low
	add  $s1, $a1, $zero 	# $s1 = k; k = low
	addi $s2, $a3, 1  	# $s2 = j; j = mid + 1

While1: 
	blt  $a3,  $s0, While2	# if mid < i then go to next While loop
	blt  $a2,  $s2, While2	# if high < j then go to next While loop
	j  If			# if i <= mid && j <=high
	
If:
	sll  $t0, $s0, 2	# $t0 = i*4
	add  $t0, $t0, $a0	# add offset to the address of a[0]; now $t2 = address of a[i]
	lw   $t1, 0($t0)	# load the value at a[i] into $t1
	sll  $t2, $s2, 2	# $t1 = j*4
	add  $t2, $t2, $a0	# add offset to the address of a[0]; now $t2 = address of a[j]
	lw   $t3, 0($t2)	# load the value of a[j] into $t3	
	blt  $t3, $t1, Else	# if a[j] < a[i], go to Else
	la   $t4, c		# Get start address of c
	sll  $t5, $s1, 2	# k*4
	add  $t4, $t4, $t5	# $t4 = c[k]; $t4 is address of c[k]
	sw   $t1, 0($t4)	# c[k] = a[i]
	addi $s1, $s1, 1	# k++
	addi $s0, $s0, 1	# i++
	j    While1		# Go to next iteration
	
Else:
	sll  $t2, $s2, 2	# $t1 = j*4
	add  $t2, $t2, $a0	# add offset to the address of a[0]; now $t2 = address of a[j]
	lw   $t3, 0($t2)	# $t3 = whatever is in a[j]	
	la   $t4, c		# Get start address of c
	sll  $t5, $s1, 2	# k*4
	add  $t4, $t4, $t5	# $t4 = c[k]; $t4 is address of c[k]
	sw   $t3, 0($t4)	# c[k] = a[j]
	addi $s1, $s1, 1	# k++
	addi $s2, $s2, 1	# j++
	j    While1		# Go to next iteration
	
While2:
	blt  $a3, $s0, While3 	# if mid < i
	sll $t0, $s0, 2		# # $t6 = i*4
	add $t0, $a0, $t0	# add offset to the address of a[0]; now $t6 = address of a[i]
	lw $t1, 0($t0)		# load value of a[i] into $t7
	la  $t2, c		# Get start address of c
	sll $t3, $s1, 2         # k*4
	add $t3, $t3, $t2	# $t5 = c[k]; $t4 is address of c[k]
	sw $t1, 0($t3) 		# saving $t7 (value of a[i]) into address of $t5, which is c[k]
	addi $s1, $s1, 1   	# k++
	addi $s0, $s0, 1   	# i++
	j While2		# Go to next iteration
	

While3:
	blt  $a2,  $s1, For_Initializer	#if high < j then go to For loop
	sll $t2, $s2, 2    	# $t6 = j*4
	add $t2, $t2, $a0  	# add offset to the address of a[0]; now $t6 = address of a[j]
	lw $t3, 0($t2)     	# $t7 = value in a[j]
	
	la  $t4, c		# Get start address of c
	sll $t5, $s1, 2	   	# k*4
	add $t4, $t4, $t5  	# $t5 = c[k]; $t4 is address of c[k]
	sw $t3, 0($t4)     	# $t4 = c[k]; $t4 is address of c[k]
	addi $s1, $s1, 1   	# k++
	addi $s2, $s2, 1   	# j++
	j While3		# Go to next iteration

For_Initializer:
	add  $t0, $a1, $zero	# initialize $s5 to low for For loop
	addi $t1, $a2, 1 	# initialize $t3 to high+1 for For loop
	la   $t4, c		# load the address of array c into $s7	
	j    For
For:
	slt $t7, $t0, $t1  	# $t4 = 1 if $s5 < $s2
	beq $t7, $zero, sortEnd	# if $t4 = 0, go to sortEnd
	sll $t2, $t0, 2   	# $s5 * 4 to get the offset
	add $t3, $t2, $a0	# add the offset to the address of a => a[$t7]
	add $t5, $t2, $t4	# add the offset to the address of c => c[$t5]
	lw  $t6, 0($t5)		# loads value of c[i] into $t6
	sw $t6, 0($t3)   	# save the value at c[$t0] to a[$t0]; a[i] = c[i]
	addi $t0, $t0, 1 	# increment $t0 by 1 for the i++ part of For loop
	j For 			# Go to next iteration

sortEnd:
	jr $ra			# return to calling routine		
Print:
	add $t0, $a1, $zero 	# initialize $t0 to low
	add $t1, $a2, $zero	# initialize $t1 to high
	la  $t4, array		# load the address of the array into $t4
	
Print_Loop:
	blt  $t1, $t0, Exit	# if $t1 < $t0, go to exit
	sll  $t3, $t0, 2	# $t0 * 4 to get the offset
	add  $t3, $t3, $t4	# add the offset to the address of array to get array[$t3]
	lw   $t2, 0($t3)	# load the value at array[$t0] to $t2
	move $a0, $t2		# move the value to $a0 for printing
	li   $v0, 1		# the MIPS call for printing the numbers
	syscall
	
	addi $t0, $t0, 1	# increment $t0 by 1 for the loop 
	la   $a0, space		# prints a comma and space between the numbers
	li   $v0, 4		# MIPS call to print a prompt
	syscall
	j    Print_Loop		# Go to next iteration of the loop
	
	
	
	

	
		
   MAIN:   

    
    # Load address for arr
    la $s0, array            # Pointer to arr goes in $t1 , load the value from the memory to register

    add $a0, $zero, $s0     # Save arr pointer to $a0
    add $a1, $zero, $s1     # Save len to $a1      #now we have two arguments a0,a1
addi $a1, $a1, 1     # Save len to $a1      #now we have two arguments a0,a1

  
    # Sort the list using selection sort
    jal SORT

    # Print list
    jal PRINT

jal binarySearch
    # Call to end program
    addi $v0, $zero, 10         # system call for exit
    syscall

SORT:
    addi $sp, $sp, -28  # make space for variables
    sw $a0, 0($sp)      # store $a0 (arr)
    sw $a1, 4($sp)      # store $a1 (len)
    sw $ra, 8($sp)      # store return address
    sw $s0, 12($sp)     # store $s0 ( i )
    sw $s1, 16($sp)     # store $s1 ( j )
    sw $s2, 20($sp)     # store $s2 (tmp)
    sw $s3, 24($sp)     # store $s3 (min)
      sw $s4, 28($sp)     # store $s3 (min)

    addi $s0, $zero, 0  # i = 0
    add $t0, $zero, $a1 # $t0 = len
    addi $t0, $t0, -1   # $t0 = len - 1

FOR_1:
    slt $t1, $s0, $t0   # i < $t0 = len - 1 continue
    beq $t1, $zero, SORT_RETURN # if !(i < len - 1) branch out of loop

    add $s3, $zero, $s0     # min = i
    addi $t1, $s0, 1    # $t1 = i + 1
    add $s1, $zero, $t1     # j = $t1 = i + 1

FOR_2: 
    slt $t1, $s1, $a1   # j < len continue
    beq $t1, $zero, IF_1    # if !(j < len) branch out of loop 

IF_2: # "FIND MIN"

    # get value at arr[ j ] store in $t3
    add $t2, $zero, $s1     # calculate index $t2 = j 
    sll $t2, $t2, 2     # offset = $t2 * 4
    add $t2, $t2, $a0   # add offset to base address
    lw $t3, 0($t2)      # load value at arr[ j ] into $t3

     # get value at arr[minIndex] store in $t5
    add $t4, $zero, $s3     # calculate index $t4 = minIndex
    sll $t4, $t4, 2     # offset = $t4 * 4
    add $t4, $t4, $a0   # add offset to base address
    lw $t5, 0($t4)      # load value at arr[minIndex] into $t5

    slt $t1, $t3, $t5   # if(arr[ j ] < arr[minIndex]) continue
    beq $t1, $zero, LOOP_2  # if !(arr[ j ] < arr[minIndex]) branch out of if stmt
    add $s3, $zero, $s1     # minIndex = j

LOOP_2:
    addi $s1, $s1, 1    # j++
    j FOR_2

IF_1: # "SWAP"
    beq $s3, $s0, LOOP_1    # if(minIndex == i) branch out of if stmt (jump to LOOP_1)


    # tmp = arr[minIndex]
    add $t2, $zero, $s3     # calculate index $t2 = minIndex
    sll $t2, $t2, 2     # offset = $t2 * 4
    add $t2, $t2, $a0   # add offset to base address
    lw $s2, 0($t2)      # $s2 = tmp = arr[minIndex]

    # arr[minIndex] = arr[ i ]
    add $t3, $zero, $s0     # calculate index $t3 = i
    sll $t3, $t3, 2     # offset = $t2 * 4
    add $t3, $t3, $a0   # add offset to base address
    lw $t0, 0($t3)      # $t0 = arr [ i ]

    sw $t0, 0($t2)      # store value at arr[ i ] in arr[minIndex] 

    # arr[ i ] = tmp
    sw $s2, 0($t3)      # store tmp value in arr[ i ]           

LOOP_1:
    addi $s0, $s0, 1    # i++
    j FOR_1 

SORT_RETURN:
    lw $a0, 0($sp)      # Get $a0
    lw $a1, 4($sp)      # Get $a1
    lw $ra, 8($sp)      # Get return address
    lw $s0, 12($sp)     # Get $s0
    lw $s1, 16($sp)     # Get $s1
    lw $s2,  20($sp)    # Get $s2
    lw $s3, 24($sp)     # Get $s3
    addi $sp, $sp 28    # Adjust stack pointer
    jr $ra          # Return

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

PRINT:
    addi $t0, $zero, 0  # $t0 = counter = 0
    add $t1, $zero, $a0 # $t1 = arr address pointer

    # Print msg1
    la $s3, msg1
    add $a0, $zero, $s3     # put address of space in $a0 to print
    addi $v0, $zero, 4  # call service 4 to print a string
    syscall         # print string

    # Print a space
    la $s3, space
    add $a0, $zero, $s3     # put address of space in $a0 to print
    addi $v0, $zero, 4  # call service 4 to print a string
    syscall         # print string

PRINT_LOOP:
    slt $t2, $t0, $a1   # if(counter < len) continue
    beq $t2, $zero, PRINT_RETURN # if(counter >= len) branch out of loop 

    add $t3, $zero, $t0     # $t3 = counter
    sll $t3, $t3, 2     # $t3 = counter * 4
    add $t3, $t3, $t1   # $t3 =  addr of arr[counter]

    lw $t4, 0($t3)      # Load value to print
    add $a0, $zero, $t4     # put address of $t4 in $a0 to print

    addi $v0, $zero, 1  # call service 1 to print integer
    syscall         # print integer

    # Check if last array element
    # Skip printing comma and space
    addi $t3, $a1, -1   # $t3 = len - 1
    beq $t3, $t0, PRINT_RETURN # if(at least element)

    # Print a comma
    la $s3, comma
    add $a0, $zero, $s3     # put address of space in $a0 to print
    addi $v0, $zero, 4  # call service 4 to print a string
    syscall         # print string

    # Print a space
    la $s3, space
    add $a0, $zero, $s3     # put address of space in $a0 to print
    addi $v0, $zero, 4  # call service 4 to print a string
    syscall         # print string

    addi $t0, $t0, 1    # counter - counter + 1

    j PRINT_LOOP

PRINT_RETURN:
    jr $ra          # Return


#______________________________________________________________________#


#char code


#-----------------------------------------------------------------------#



charCode:
#print message to choose the type of sorting
	li $v0, 4 
	la $a0, sortchoosing
	syscall
	li $v0 ,5#loading 5 to input integer 
	syscall
	move $t0 , $v0 #move the value in $v0 to $t0
	addi $t1,$zero,1
	beq $t0,$t1,BUBelChar
	addi $t1,$zero,2
	beq $t0,$t1,MERGEChar
	
	addi $t1,$zero,3
	beq $t0,$t1,selectedSortChar 
	














MERGEChar:
	# print enter string
	li $v0, 4
	la $a0, message
	syscall
	#input string
	li $v0, 8
	la $a0, arr
	li $a1, 1000
	syscall
	
	#counter 
	addi $t0, $zero, 0
	la $a1, ($a0)
	whileChar:
	lb $t6, 0($a1)
	beqz $t6, exitChar
	lb $t4,arr($t0)
	addi $t0, $t0, 1
	addi $a1, $a1, 1
	
	j whileChar
	
	exitChar:
	#print given array
	li $v0, 4
	la $a0, given
	syscall
	li $v0, 4
	la $a0, arr
	syscall
	#print new line
	li $v0, 4
	la $a0, newline
	syscall
	#print the counter
	subi $s0, $t0, 1
	li $v0, 1
	move $a0, $s0
	syscall
	sw $s0,arraySize	
	#print new line
	li $v0, 4
	la $a0, newline
	syscall
	#declaring the start and end of the array
	addi $a1, $zero, 0
	addi $a2, $s0, -1
	#calling merge function 
	jal mergeSortChar
	#printing the result
	li $v0, 4
	la $a0, sorted
	syscall
	li $v0, 4
	la $a0, arr
	syscall
	lw $t0, arraySize
	addi $t1,$zero,0
	la $a0,array 
	#la $a1, ($a0)
	#printing array (arr) in array (array)
	copyingArray:
	slt $t5, $t1,$t0
	beqz $t5,binarySearchChar
	lb $t3,arr($t1)
	sw $t3, 0($a0)
	addi $a0 ,$a0 ,4
	addi $t1, $t1,1
	jal copyingArray
	#jal binarySearchChar
	#this in dicates the end of the program
	li $v0, 10
	syscall 


		         
	mergeSortChar:
	#comparing left and right positions of the array to prevent overflow 
	 		slt $t4, $a1, $a2
		 	beqz $t4,exitsChar
	#reserving space in stack
			subi $sp, $sp, 16
	 		sw $ra , ($sp)
	 		sw $a1, 8($sp)	#left position
	 		sw $a2, 12($sp)	#right position 	 	
	#if left position is smaller than right position	
	#declaring mid point 
	 		add $t0, $a1, $a2 #m=l+r
	 		subi $t0, $t0,1 #m=l+r-1
	 		div $t0, $t0, 2# m= l+r-1/2
	 		sw $t0, 4($sp)
	 		
	#first recursion 
			lw $a1, 8($sp)
	 		lw $a2, 4($sp)
	 		jal mergeSortChar
	#second recursion		
	 		lw $a0, 4($sp)	#mid point
	 		lw $a1, 8($sp)	#left position
	 		lw $a2, 12($sp)	#right position 
	 		addi $a1, $a0 ,1
	 		jal mergeSortChar
	#calling merging function
			lw $a0, 4($sp)	#mid point
	 		lw $a1, 8($sp)	#left position
	 		lw $a2, 12($sp)	#right position	
	 		jal mergingChar
	 		lw $ra , ($sp)
	 		addi $sp,$sp,16
	 		jr $ra
	 		

	mergingChar:
	# intializing sizes of the arrays
		addi $t5,$zero,0
		sub $t5,$a0,$a1
		addi $t5,$t5,1 #$t5 is for S1
		addi $t6, $zero,0
		sub $t6,$a2,$a0 #t6 is for S2
	
	#while loop to declare left array
		addi $s3, $zero,0
		leftarraycopyChar:
			      	slt $t7, $s3,$t5 #i<S1
				beqz $t7, afterleftarraycopyChar
				add $t3, $a1,$s3 #index for array (l+i)
				lb $t4, arr($t3)#loading the value at index (l+i) in $t4
				sb $t4, leftarray($s3)#L[i]=arr[l+i]
				addi $s3,$s3,1#i=i+1
				j leftarraycopyChar
	
	#declaring right array
		afterleftarraycopyChar:
			addi $s4, $zero,0 #j=0
			lw $a0, 4($sp)
		rightarraycopyChar:
			      	slt $t7, $s4,$t6# check if j<S2
				beqz $t7,afterRightarraycopyChar
				add $t3, $a0,$s4 #index for array (m+j)
				addi $t3,$t3,1   #here index will be (m+j+1)
				lb $t4, arr($t3)#loading the value at index (m+j+1) in $t4
				sb $t4, rightarray($s4)#R[j]=arr[m+j+1]
				addi $s4,$s4,1# increment j by 1
				j rightarraycopyChar
		afterRightarraycopyChar:
		addi $s3,$zero,0
		addi $s4,$zero,0
		lw $s5, 8($sp)
		#comparing values while loop
		comparingChar:
			slt $t7,$s3, $t5#checking (i<S1)
			beqz $t7,endwhileChar
			slt $t7 ,$s4,$t6#checking (j<S2)
			beqz $t7,endwhileChar
			lb $t3, leftarray($s3)#put L[i]in $t3
			lb $t4,rightarray($s4)#putR[j]in $t4
			slt $t7,$t3,$t4 #if l[i]< R[j]
			beqz $t7, ifequalChar
			sb $t3, arr($s5) #equivalent to arr[k]=L[i]
			addi $s3,$s3,1 #increment i by 1
					
			addi $s5,$s5,1 #increment k by 1
			j comparingChar
			ifequalChar:
				bne $t3,$t4,elseChar #if L[i} not equal to R[j] go to else
				sb $t3, arr($s5) #equivalent to arr[k]=L[i]
				addi $s3,$s3,1 #increment i by 1
				addi $s5,$s5,1 #increment k by 1
				j comparingChar
			elseChar:
				sb $t4,arr($s5) #equivalent to arr[k]=R[j]
				addi $s4,$s4,1 #increment j by 1		
				addi $s5,$s5,1 #increment k by 1
				j comparingChar
		endwhileChar:
			slt $t7,$s3, $t5# if i < S1
			beqz $t7, secondwhileChar #if not go to second loop
			lb $t3, leftarray($s3)#put L[i] in $t3
			sb $t3, arr($s5)#equivalent to arr[k]=L[i]
			addi $s3,$s3,1 #increment i by 1
			addi $s5,$s5,1#increment k by 1
			j endwhileChar
		secondwhileChar:
				slt $t7, $s4,$t6 #if j< S2  
				beqz $t7, endfunctionChar# if not go to end function
				lb $t3 , rightarray($s4)#put R[j] in $t3
				sb $t3, arr($s5)#equivalent to arr[k]=R[j]
				addi $s4,$s4,1#increment j by1
				addi $s5,$s5,1# increment k by 1
				j secondwhileChar
		endfunctionChar:					
			jr $ra
		
	exitsChar: 	
 	   	jr $ra
		








#--------------------------------------------------------------------------
BUBelChar:                                                       # start of the main procedure

#
# print to ask user to enter the size of the array
la $a0,size                                                 # Load message to print size to $a0 to be able to print it
li $v0,4                                                    # call service 4 to print a String to the screen
syscall                                                     # tell system to do it

li $v0,5                                                    # call service 5 to read an integer and store it in $v0
syscall                                                     # ask the system to prompt an integer

sw $v0,arraySize

move $s1, $v0                                               # move the size value to register $s1


addcharChar:                                                    # start of addchar function 

la $a0,enter_char                                           # print the message to ask the user to enter an integer
li $v0,4                                                    # call service 4 to print a string
syscall

li $v0,12                                                    # read a char from the user
syscall

move $t3,$v0                                                # move the char into $t3
add $t1,$zero,$zero                                         # make $t1 = 0
sll $t1,$t0,2                                               # shift the number 2 places left which means $t1 = $t0 * 4
sw $t3,array ( $t1 )                                        # store the value of $t3 (our char) to the array of address starting from adress of the first element + $t1


addi $t0,$t0,1                                              # $t0 = $t0 + 1
slt $t1,$s1,$t0                                             # $t1 is 1 if $s1(size-1) < $t0(counter) and continue the next instructions
beq $t1,$zero,addcharChar                                        # else if $s1 >= $t0 then $t1 = 0 and apply the loop again

la $a0,array                                                #load the pointer of array to $a0 (argument 0)
addi $a1,$s1,1                                              # load the array size to $a1 (argument 1)

jal bubble_sortChar                                             # set the $ra (program counter) then go to the bubble_sort function

la $a0,final                                                # after sorting the array we load the message final to be printed to the user
li $v0,4                                                    # service 4 for printing a string
syscall

la $t0,array                                                # load the address of the array to t0 
li $t1,0                                                    # $t1 = 0

printChar:
lw $a0,0($t0)                                               # load the item in $t0 address to $a0
li $v0,11                                                   # call service 11 to print a char
syscall                                                     # print the char we choose

la $a0,space                                                # print a space between each char
li $v0,4                                                    #service 4 to print a string
syscall

addi $t0,$t0,4                                              # $t0 = $t0 + 4
addi $t1,$t1,1                                              # t1 = t1 + 1
slt $t2,$s1,$t1                                             # if $s1 (size) < $t1 set $t2 = 1 and break
beq $t2,$zero,printChar                                         # else $t2 = 0 and print again

jal binarySearchChar
li $v0,10                                                   # call service 10 to exit the program
syscall                                         

# function for sorting the array using Bubble sort Algorithm
bubble_sortChar:
li $t0,0                                                    # set $t0 to 0                     

loop1Char:

addi $t0,$t0,1                                              #set counter to 1
bgt $t0,$a1,endChar                                             # if the counter > array size then break and go to end        
add $t1,$a1,$zero                                           # $t1 = size 

loop2Char:

bge $t0,$t1,loop1Char                                           # if counter >= $t1(size) then break and go to loop 1

subi $t1,$t1,1                                              # t1(initially the size) = t1 - 1

sll $t4, $t1, 2                                             # $t4 = $t1 (size - 1) * 4 --> shifting left by 2
subi $t3, $t4, 4                                            # $t3 = $t4 - 4                 

add $t4,$t4,$a0                                             # we add the array address and t4 and store it in t4
add $t3,$t3,$a0                                             # we add the array address and t3 and store it in t3
lw $t5,0($t4)                                               # we load the integer which is in $t4 address and store it in $t5 
lw $t6,0($t3)                                               #we load the integer in $t3 address (the element before the above one) and store it in $t6 

swapChar:
bgt $t5,$t6,loop2Char                                           #if the item in $t5 > the one in $t6 we return to the loop for the next round
sw $t5,0($t3)                                               #else we swap the two integers, we  replace the item in $t5 by the item in $t3 address
sw $t6,0($t4)                                               # and we replace the itme in $t6 by the item in $t4 address
j loop2Char                                                     #we finish this loop round 
                                                 #we finish this loop round 
#------------------------------------------------------------


  selectedSortChar:   
la $a0,size                                                 # Load message to print size to $a0 to be able to print it
li $v0,4                                                    # call service 4 to print a String to the screen
syscall  


    # Ask for user input and put value in $s1
    addi $v0, $zero, 5    # call service 5 for integer input
    syscall             # read integer
   sw $v0,arraySize
     add $s1, $zero, $v0         # Save $t0 = len

la $a0,enterAsStr                                                
li $v0,4                                                   
syscall  
    # Load address for arrayay
    la $s0, array             # Pointer to arrayay goes in $t1 , load the value from the memory to register

    add $a0, $zero, $s0     # Save arrayay pointer to $a0
    add $a1, $zero, $s1     # Save len to $a1      #now we have two arguments a0,a1


    # Ask for user input to fill arrayay
    jal FILLChar

    # Sort the list using selection sort
    jal SORTChar

    # Print list
    jal PRINTChar
jal binarySearchChar
    # Call to end program
    addi $v0, $zero, 10         # system call for exit
    syscall

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

FILLChar: # deal with stack and save
    addi $t0, $zero, 0      # $t0 = counter = 0 

FILL_LOOPChar:
    slt $t1, $t0, $a1       # if(counter < len) continue
    beq $t1, $zero, FILL_RETURNChar     # if(counter >= len) break 
    addi $v0, $zero, 12       # call service 12 for char input
    syscall             # read char
    addiu $t1, $v0, 1
   
    addi $t2, $zero, 0      # clear $t2 and set to 0
    add $t2, $zero, $v0         # $t2 holds input char

    add $t3, $zero, $t0         # $t3 = counter
    sll $t3, $t3, 2         # $t3 =  counter * 4 (4 is for the space of a word)
    add $t3, $t3, $a0       # addr of first element in arrayay + t3 = addr of second element.
    sw $t2, 0($t3)          # store values in arrayay

    addi $t0, $t0, 1        # counter = counter + 1

    j   FILL_LOOPChar

FILL_RETURNChar:
    jr $ra              # Return

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

SORTChar:
    addi $sp, $sp, -28  # make space for variables
    sw $a0, 0($sp)      # store $a0 (arrayay)
    sw $a1, 4($sp)      # store $a1 (len)
    sw $ra, 8($sp)      # store return address
    sw $s0, 12($sp)     # store $s0 ( i )
    sw $s1, 16($sp)     # store $s1 ( j )
    sw $s2, 20($sp)     # store $s2 (tmp)
    sw $s3, 24($sp)     # store $s3 (min)

    addi $s0, $zero, 0  # i = 0
    add $t0, $zero, $a1 # $t0 = len
    addi $t0, $t0, -1   # $t0 = len - 1

FOR_1Char:
    slt $t1, $s0, $t0   # i < $t0 = len - 1 continue
    beq $t1, $zero, SORT_RETURNChar # if !(i < len - 1) branch out of loop

    add $s3, $zero, $s0     # min = i
    addi $t1, $s0, 1    # $t1 = i + 1
    add $s1, $zero, $t1     # j = $t1 = i + 1

FOR_2Char: 
    slt $t1, $s1, $a1   # j < len continue
    beq $t1, $zero, IF_1Char    # if !(j < len) branch out of loop 

IF_2Char: # "FIND MIN"

    # get value at arrayay[ j ] store in $t3
    add $t2, $zero, $s1     # calculate index $t2 = j 
    sll $t2, $t2, 2     # offset = $t2 * 4
    add $t2, $t2, $a0   # add offset to base address
    lw $t3, 0($t2)      # load value at arrayay[ j ] into $t3

     # get value at arrayay[minIndex] store in $t5
    add $t4, $zero, $s3     # calculate index $t4 = minIndex
    sll $t4, $t4, 2     # offset = $t4 * 4
    add $t4, $t4, $a0   # add offset to base address
    lw $t5, 0($t4)      # load value at arrayay[minIndex] into $t5

    slt $t1, $t3, $t5   # if(arrayay[ j ] < arrayay[minIndex]) continue
    beq $t1, $zero, LOOP_2Char  # if !(arrayay[ j ] < arrayay[minIndex]) branch out of if stmt
    add $s3, $zero, $s1     # minIndex = j

LOOP_2Char:
    addi $s1, $s1, 1    # j++
    j FOR_2

IF_1Char: # "SWAP"
    beq $s3, $s0, LOOP_1Char    # if(minIndex == i) branch out of if stmt (jump to LOOP_1)


    # tmp = arrayay[minIndex]
    add $t2, $zero, $s3     # calculate index $t2 = minIndex
    sll $t2, $t2, 2     # offset = $t2 * 4
    add $t2, $t2, $a0   # add offset to base address
    lw $s2, 0($t2)      # $s2 = tmp = arrayay[minIndex]

    # arrayay[minIndex] = arrayay[ i ]
    add $t3, $zero, $s0     # calculate index $t3 = i
    sll $t3, $t3, 2     # offset = $t2 * 4
    add $t3, $t3, $a0   # add offset to base address
    lw $t0, 0($t3)      # $t0 = arrayay [ i ]

    sw $t0, 0($t2)      # store value at arrayay[ i ] in arrayay[minIndex] 

    # arrayay[ i ] = tmp
    sw $s2, 0($t3)      # store tmp value in arrayay[ i ]           

LOOP_1Char:
    addi $s0, $s0, 1    # i++
    j FOR_1Char 

SORT_RETURNChar:
    lw $a0, 0($sp)      # Get $a0
    lw $a1, 4($sp)      # Get $a1
    lw $ra, 8($sp)      # Get return address
    lw $s0, 12($sp)     # Get $s0
    lw $s1, 16($sp)     # Get $s1
    lw $s2,  20($sp)    # Get $s2
    lw $s3, 24($sp)     # Get $s3
    addi $sp, $sp 28    # Adjust stack pointer
    jr $ra          # Return

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

PRINTChar:
    addi $t0, $zero, 0  # $t0 = counter = 0
    add $t1, $zero, $a0 # $t1 = arrayay address pointer

    # Print msg1
    la $s3, msg1
    add $a0, $zero, $s3     # put address of space in $a0 to print
    addi $v0, $zero, 4  # call service 4 to print a string
    syscall         # print string

    # Print a space
    la $s3, space
    add $a0, $zero, $s3     # put address of space in $a0 to print
    addi $v0, $zero, 4  # call service 4 to print a string
    syscall         # print string

PRINT_LOOPChar:
    slt $t2, $t0, $a1   # if(counter < len) continue
    beq $t2, $zero, PRINT_RETURNChar # if(counter >= len) branch out of loop 

    add $t3, $zero, $t0     # $t3 = counter
    sll $t3, $t3, 2     # $t3 = counter * 4
    add $t3, $t3, $t1   # $t3 =  addr of arrayay[counter]

    lw $t4, 0($t3)      # Load value to print
    add $a0, $zero, $t4     # put address of $t4 in $a0 to print

    addi $v0, $zero, 11  # call service 11 to print char
    syscall         # print char

    # Check if last arrayayay element
    # Skip printing comma and space
    addi $t3, $a1, -1   # $t3 = len - 1
    beq $t3, $t0, PRINT_RETURNChar # if(at least element)

    # Print a comma
    la $s3, comma
    add $a0, $zero, $s3     # put address of space in $a0 to print
    addi $v0, $zero, 4  # call service 4 to print a string
    syscall         # print comma

    # Print a space
    la $s3, space
    add $a0, $zero, $s3     # put address of space in $a0 to print
    addi $v0, $zero, 4  # call service 4 to print a string
    syscall         # print string

    addi $t0, $t0, 1    # counter - counter + 1

    j PRINT_LOOPChar

PRINT_RETURNChar:
    jr $ra          # ReturnS


#------------------------------------------#






 
  binarySearchChar:
  lw $t9, arraySize
  
  li $v0, 4
  la $a0, newline
  syscall
  
  
  li $v0, 4
  la $a0, ssearsh
  syscall
  
  li $v0, 12
  syscall
  move $t0,$v0 # find x =$t0
  
  add $t1,$zero, $t9# Right side

  addi $t2,$zero,0 # left side
  
  addi $t3,$zero,0 # mid
  
  loopChar:
  add $t3,$t2,$t1
  div $t3,$t3,2
  
  mul $t4,$t3,4
 
  lw $t5,array($t4)
  beq $t5,$t0,FoundChar
  slt $t6,$t5,$t0
  beq $t6,1,greatleftChar
  add $t1,$t1,-1
   
   j fiChar
  greatleftChar:
  add $t2,$t2,1
  fiChar:
  slt $s1,$t1,$t2
  beq $s1,1,notFoundChar
  j loopChar
  FoundChar:
  
  
  li $v0, 4
  la $a0, newline
  syscall
  
  li $v0, 4
  la $a0, found_mess
  syscall
  
  li $v0, 1
  move $a0, $t3
  syscall
  
  # Call to end program
    addi $v0, $zero, 10         # system call for exit
    syscall
  notFoundChar:
  
  li $v0, 4
  la $a0, newline
  syscall
 li $v0, 4
  la $a0, notfound_mess
  syscall
  
 # Call to end program
    addi $v0, $zero, 10         # system call for exit
    syscall




#---------------------------------------------------------------------------------
endChar:
jr $ra                                                     #return to the last place stored in the program counter




	
Exit:
	j binarySearch
li $v0,10                                                   # call service 10 to exit the program
syscall   
	jr $ra			# jump to the address in $ra; Go back to main
	

exiteee:
li $v0,10                                                   # call service 10 to exit the program
syscall                                         
