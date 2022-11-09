# calculator.s 
#Name : Edmond Huang
#Date : February 18 2022
#Purpose : This program implements simple arithmetic instructions (compare, addition, subtration, multiplication) by x86-64 Assembly Language.

	.globl	compare # Make sure you change the name of this function - see XX function below
	.globl	plus
	.globl	minus
	.globl	mul


# x in edi, y in esi

compare: # Compares x and y. If y > x, return 1. If x > y, return 0.
	xorl	%eax, %eax
	cmpl	%esi, %edi
	setl	%al         # See Section 3.6.2 of our textbook for a description of the set* instructions (Set if less)
	ret

plus:  # performs integer addition
# Requirement:
# - you cannot use add* instruction
# - you cannot use a loop
	
	xorl	%eax, %eax					#zeros out result
	leal	(%edi,	%esi),	%eax		#adds x and y into result using load effective address
	ret									#return result

minus: # performs integer subtraction
# Requirement:
# - you cannot use sub* instruction
# - you cannot use a loop
	
	xorl	%eax, 	%eax		#zeros out result
	movl	%edi,	%eax		#moves x into result 
	negl	%esi				#makes y negative so x - y becomes x + (-y)
	addl	%esi,	%eax		#adds -y to x
	negl	%esi				#restores y to previous sign
	ret							#return result


mul: 
# performs integer multiplication - when both operands are non-negative!
# You can assume that both parameters are non-negative.
# Requirements:
# - you cannot use imul* instruction
# (or any kind of instruction that multiplies such as mul)
# - you must use recursion (no loop) and the stack
	
	xorl	%eax,	%eax		#zeros out result
	
.func:
	testl	%esi,	%esi		#tests if y is 0
	je		.done				#if y is zero, move to done

	pushq	%rsi				#saves y in stack
	pushq	%rdi				#saves x to stack

	addl	%edi,	%eax		#adds result by y
	decl	%esi				#decrements y by 1
	call	.func				#recursion back to function 

	popq	%rdi				#restores x
	popq	%rsi				#restores y

.done:
	
	ret
	
	

# algorithm:
#
#
#
#