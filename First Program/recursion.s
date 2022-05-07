.text
.globl main

main:								# pika e fillimit për ekzekutimin e kodit
	addi $a0, $zero, 8				# inicializojme vleren 4 ne regjistrin $a0 - argumentin 1
	add $t0, $a0, $zero 			# lloj i zhvendosjes(move) se vleres se $a0 ne $t0 mirepo permes mbledhjes, pra vendosim vleren 4 tek regjistri $t0 - temporary usage
	
	jal printFun					# jal- jump and link, kercen tek funksioni "printFun" dhe ruan return address($ra) adresen kthyese te instruksionit te ardhshem 

	j ExitProgram


printFun:							# funksioni(procedura) printFun
	addi $sp, $sp, -8				# Rregullojme "marrim" 2 vende nga stack pointeri -> 2 vende per shkak se kemi te bejme me integers pra nje integer ze hapesire prej 4 bytes dhe gjithashtu nje hapesire per return address $ra -> pra gjithsej 8 bytes
	sw $ra, 4($sp)					# e ruajme return address ($ra) ne 4 bytet e larte nga 8 sa kemi marre tek $sp
	sw $t0, 0($sp)					# e ruajme $t0 tek 4 bytet e poshtem nga 8 sa kemi marre tek $sp

	slti $t1, $t0, 1				# slti - Set to 1 if Less Than Immediate - nese $t0<1 atehere $t1=1, nderkaq nese $t0>1 atehere $t1=0
	beq $t1, $zero, Steps			# kushtezim! nese $t1 dhe $zero jane te barabarte kercejme tek Steps, nderkaq nese nuk jane te barbarte vazhdojme me instruksionin qe eshte me radhe pra rritja e $sp per 8 

	addi $sp, $sp, 8				# e rrisim stack pointerin per 8 bytes
	jr $ra 							# kthehemi te return address

Steps:								# funksioni i cili thirret kur $t0 nuk eshte me i vogel se 1
	li $v0, 1 						# bejme printimin e variables $t0 qe ne fillim eshte 4 pastaj shkon duke u zbritur derisa nuk plotsohet kushti beq me larte
	move $a0, $t0		
	syscall
	li $v0, 4						# bejme printimin e hapesires pas numrit te printuar per te bere ndarjen e tyre
	la $a0, space
	syscall
	addi $t0, $t0, -1				# zbresim vleren e regjistrit $t0 per -1

	jal printFun					# kercejme tek funksioni printFun

	lw $t0, 0($sp)					# pasi qe kemi perfunduar printimin e numrave 4,3,2,1 dhe ruajtjen e tyre ne $sp - stack pointer, fillojme me nxjerrjen e tyre hap pas hapi pra sipas parimit LIFO - Last In First Out, ku gjitashtu bejme edhe kthimin e return address hap pas hapi
	lw $ra, 4($sp)					
	addi $sp, $sp, 8				# rrisim stack pointerin per 8 bytes pra shkojme tek numri i radhes

	li $v0, 1 						# bejme printimin(shtypjen) e numrave me radhe qe i kemi nxjerre nga $sp
	move $a0, $t0
	syscall

	li $v0, 4						# bejme printimin(shtypjen) e hapesirave mes numrave per te bere ndarjen e tyre
	la $a0, space
	syscall

	jr $ra 							# kercejme tek adresa para funksionit printFun aty ku kemi bere jal per here te pare, aty ku edhe shkojme tek Labela ExitProgram dhe bejme perfundimin e programit

ExitProgram:						# Labeli ExitProgram
	li $v0, 10						# Ketu kam bere daljen ose perfundimin e programit sipas tabeles e dijme qe vlera 10 ruhet per daljen nga programi
	syscall
	
.data								# deklarimi i data - ketu deklarojme emrat e variablave të përdorur në program
	space: .asciiz " "					# variabla space qe permban nje hapesire te cilen e kam perdorur per hapesiren ne mes numrave gjate printimit te tyre
