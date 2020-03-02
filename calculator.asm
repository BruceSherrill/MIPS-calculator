.data
	welcome_prompt:	  .asciiz "Hello, What type of calculation can I help you with today? (Addition = 1, Subtraction=2, Multiplications =3, Division = 4)\n"
	var1_prompt:  .asciiz "\nI can do that. What is your first number?\n"
	var2_prompt: .asciiz "\nGood, what is your second number?\n"
	result_prompt: .asciiz "\nGreat! The result is: "
	again_prompt: .asciiz "\nWould you like to do another calculation? 0=no 1=yes\n"
	
	#t0 - opperand input
	#t1 - variable input 1
	#t2 - variable input 2
	#t3 - 6 constants to determing what opperand user wants
	#t7 - result
	#t8 - while loop condition
	
	
	
.text
main:
#SYSTEM CALLING CODES: http://students.cs.tamu.edu/tanzir/csce350/reference/syscalls.html
# 1  - print integer
# 4  - print string
# 5  - read integer input
# 10 - exit/end program

	#constants to compare user opperand selection too
	addi $t3, $zero, 1	#add
	addi $t4, $zero, 2	#subtract
	addi $t5, $zero, 3	#multi
	addi $t6, $zero, 4	#divide
	
	addi $t8, $zero, 1

	while:
	bgt $t3, $t8, exit
	
#OPPERAND INPUT
	#prints welcome prompt
	li $v0, 4		#telling computer to print string
	la $a0, welcome_prompt	#loads welcome_prompt into argument 0
	syscall
	
	#get the user's input
	li, $v0, 5		#read variable input into $v0
	syscall
	
	#store the result in $t0  moving it from v0->t0
	move $t0, $v0		#moves user input into Temporary 0
	
	
	
#VARIABLE INPUT 1
	#prints variable_input1
	li $v0, 4		#telling computer to print string
	la $a0, var1_prompt	#loads var1_prompt into argument 0
	syscall
	
	#get the user's input
	li, $v0, 5		#reads variable input into $v0
	syscall
	
	#store the result in $t0  moving it from v0->t1
	move $t1, $v0		#moves user input into Temporary 1
	
	
#VARIABLE INPUT 2
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, var2_prompt	#loads var2_prompt into argument 0
	syscall
	
	#get the user's input
	li, $v0, 5		#reads variable into $v0
	syscall
	
	#store the result in $t0  moving it from v0->t2
	move $t2, $v0		#moves user input into Temporary 2
	
	
	
	
	
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
	la $a0, result_prompt	#loads result_prompt into argument 0
	syscall
	
	#displays result
	li $v0, 1		#telling computer to print integer
	move $a0, $t7		#moves $t7(result) into argument 0
	syscall
	
	li $v0, 4
	la $a0, again_prompt
	syscall
	
	li $v0, 5
	syscall
	
	move $t8, $v0
	
	j while
	
	
	
Subtraction:
	sub $t7,$t1,$t2
	
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, result_prompt	#loads result_prompt into argument 0
	syscall
	
	#displays result
	li $v0, 1		#telling computer to print integer
	move $a0, $t7		#moves $t7(result) into argument 0
	syscall
	
	li $v0, 4
	la $a0, again_prompt
	syscall
	
	li $v0, 5
	syscall
	
	move $t8, $v0
	
	j while
	
	
Division:
	div $t7,$t1,$t2
	
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, result_prompt	#loads result_prompt into argument 0
	syscall
	
	#displays result
	li $v0, 1		#telling computer to print integer
	move $a0, $t7		#moves $t7(result) into argument 0
	syscall
		
	li $v0, 4
	la $a0, again_prompt
	syscall
	
	li $v0, 5
	syscall
	
	move $t8, $v0
	
	j while


Multiplication:
	mul $t7,$t1,$t2
	
	#prints variable_input2
	li $v0, 4		#telling computer to print string
	la $a0, result_prompt	#loads result_prompt into argument 0
	syscall
	
	#displays result
	li $v0, 1		#telling computer to print integer
	move $a0, $t7		#moves $t7(result) into argument 0
	syscall
	
	li $v0, 4
	la $a0, again_prompt
	syscall
	
	li $v0, 5
	syscall
	
	move $t8, $v0
	
	j while
	
	

	exit:
	li $v0, 10
	syscall
	
	