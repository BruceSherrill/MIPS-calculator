.data
	welcome_Prompt:	.asciiz "Hello, What type of calculation can I help you with today? (Addition = 1, Subtraction=2, Multiplications =3, Division = 4)\n"
	var1_Prompt:	.asciiz "I can do that. What is your first number?\n"
	var2_Prompt:	.asciiz "\nGood, what is your second number?\n"
	result_Prompt:  .asciiz "\nGreat! The result is: "
	again_Prompt:   .asciiz "\nWould you like to do another calculation? 0=no 1=yes\n"
	
	addition_Prompt:.asciiz "\nAddition, "
	subtraction_Prompt:.asciiz "\nSubtraction, "
	multiplication_Prompt:.asciiz "\nMultiplication, "
	division_Prompt:.asciiz "\nDivision, "

	
	#t0 - operator input
	#t1 - variable input 1
	#t2 - variable input 2
	#t3 - 6 constants to determing what operator user wants
	#t7 - result
	#t8 - while loop condition

	
.text
main:
#RESOURCES:
#MIPS REFRENCE SHEET:	 http://www.cburch.com/cs/330/reading/mips-ref.pdf
#REGISTER USES:		 http://homepage.divms.uiowa.edu/~ghosh/6016.2.pdf
#SYSTEM CALLING CODES: 	 http://students.cs.tamu.edu/tanzir/csce350/reference/syscalls.html

# 1  - print integer
# 4  - print string
# 5  - read integer input
# 10 - exit/end program

	#constants to compare user operator selection too
	addi $t3, $zero, 1	#add
	addi $t4, $zero, 2	#subtract
	addi $t5, $zero, 3	#multi
	addi $t6, $zero, 4	#divide
	
	addi $t8, $zero, 1	#while loop variable


#WHILE LOOP
	while:
	bgt $t3, $t8, exit	#branch to exit if $t3(1) is greater than $t8(user again_prompt input)
	
	
	
#OPPERATOR INPUT
	#prints welcome prompt
	li $v0, 4		#telling computer to print string
	la $a0, welcome_Prompt	#loads welcome_prompt into argument 0
	syscall
	
	#get the user's input
	li, $v0, 5		#read variable input into $v0
	syscall
	
	#store the result in $t0  moving it from v0->t0
	move $t0, $v0		#moves user input into Temporary 0
	
	
	
#VARIABLE INPUT 1	

	beq $t0, $t3, print_Addition		#if users opperator = the addition operator print go to print_Addition
	beq $t0, $t4, print_Subtraction		#if users opperator = the subtraction operator print go to print_Subtraction
	beq $t0, $t5, print_Multiplication	#if users opperator = the multiplication operator print go to print_Multiplication
	beq $t0, $t6, print_Division		#if users opperator = the division operator print go to print_Division
	
#prints the operators word (Extra credit)
print_Addition:
	li $v0, 4		#telling computer to print string
	la $a0, addition_Prompt	#loads welcome_prompt into argument 0
	syscall
	j get_Variables		#jumps to get_variable
	
print_Subtraction:
	li $v0, 4			#telling computer to print string
	la $a0, subtraction_Prompt	#loads subtraction_prompt into argument 0
	syscall
	j get_Variables			#jumps to get_variable
	
print_Multiplication:
	li $v0, 4			#telling computer to print string
	la $a0, multiplication_Prompt	#loads multiplication_prompt into argument 0
	syscall
	j get_Variables			#jumps to get_variable
	
print_Division:
	li $v0, 4			#telling computer to print string
	la $a0, division_Prompt		#loads division_prompt into argument 0
	syscall
	j get_Variables			#jumps to get_variable




get_Variables:
	#prints variable_input1
	li $v0, 4		#telling computer to print string
	la $a0, var1_Prompt	#loads var1_prompt into argument 0
	syscall
	
	#get the user's input
	li, $v0, 5		#reads variable input into $v0
	syscall
	
	#store the result in $t0  moving it from v0->t1
	move $t1, $v0		#moves user input into Temporary 1
	
	
	
#VARIABLE INPUT 2
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, var2_Prompt	#loads var2_prompt into argument 0
	syscall
	
	#get the user's input
	li, $v0, 5		#reads variable into $v0
	syscall
	
	#store the result in $t0  moving it from v0->t2
	move $t2, $v0		#moves user input into Temporary 2
	


#IF STATEMENTS
	#branch if equal to addition 
	beq $t0, $t3, Addition
	
	#branch if equal to Subtraction
	beq $t0, $t4, Subtraction
	
	#branch if equal to Multiplication 
	beq $t0, $t5, Multiplication
	
	#branch if equal to Division 
	beq $t0, $t6, Division
	
	
	
Addition:
	add $t7,$t1,$t2
	
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, result_Prompt	#loads result_prompt into argument 0
	syscall
	
	#displays result
	li $v0, 1		#telling computer to print integer
	move $a0, $t7		#moves $t7(result) into argument 0
	syscall
	
	#displays again prompt	
	li $v0, 4		#telling computer to print string		
	la $a0, again_Prompt	#loads again_prompt into argument 0
	syscall
	
	li $v0, 5		#reads variable into $v0
	syscall
	
	move $t8, $v0		#moves $v0 to Temporary 8
	
	j while			#jump to while
	
	
	
Subtraction:
	sub $t7,$t1,$t2
	
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, result_Prompt	#loads result_prompt into argument 0
	syscall
	
	#displays result
	li $v0, 1		#telling computer to print integer
	move $a0, $t7		#moves $t7(result) into argument 0
	syscall
	
	#displays again prompt	
	li $v0, 4		#telling computer to print string
	la $a0, again_Prompt	#loads again_prompt into argument 0
	syscall
	
	li $v0, 5		#reads variable into $v0
	syscall
	
	move $t8, $v0		#moves $v0 to Temporary 8
	
	j while			#jump to while
	
	
	
Division:
	div $t7,$t1,$t2
	
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, result_Prompt	#loads result_prompt into argument 0
	syscall
	
	#displays result
	li $v0, 1		#telling computer to print integer
	move $a0, $t7		#moves $t7(result) into argument 0
	syscall
	
	#displays again prompt	
	li $v0, 4		#telling computer to print string
	la $a0, again_Prompt	#loads again_prompt into argument 0
	syscall
	
	li $v0, 5		#reads variable into $v0
	syscall
	
	move $t8, $v0		#moves $v0 to Temporary 8
	
	j while			#jump to while



Multiplication:
	mul $t7,$t1,$t2
	
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, result_Prompt	#loads result_prompt into argument 0
	syscall
	
	#displays result
	li $v0, 1		#telling computer to print integer
	move $a0, $t7		#moves $t7(result) into argument 0
	syscall
	
	#displays again prompt	
	li $v0, 4		#telling computer to print string
	la $a0, again_Prompt	#loads again_prompt into argument 0
	syscall
		
	li $v0, 5		#reads variable into $v0
	syscall
	
	move $t8, $v0		#moves $v0 to Temporary 8
	
	j while			#jump to while
		
	
#PROGRAM EXIT
	exit:
	li $v0, 10		#exit/end program
	syscall
	
	
