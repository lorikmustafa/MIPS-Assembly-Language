.text
.globl main

main: 												# pika e fillimit për ekzekutimin e kodit									
		li $v0, 4									# Printimi i textOutput 
		la $a0, textOutput 
		syscall

		lw $t5, size   								# Japim vleren e size tek $t5
		la $a1, numbers  	 						# Japim adresen e vargut tek regjistri $a1
		li $t2, 0           						# Japim vleren 0 tek $t2 (si nje lloj "counter" per te na sherbyer per te iteruar ne varg)
		addi $t0, $zero, 2  						# Japim vleren 2 tek $t0 per te na ndihmuar ne pjesetim

loop:												# Fillimi i loop
		beq $t2, $t5, end							# Shikojme nese eshte fundi i vargut pra nese $t2=$t5
		lw $s1, ($a1)								# Japim vleren e pare te vargut tek $s1
		div $s1, $t0								# Pjestojme ate vlere me numrin e ruajtur tek $t0, pra me 2, per te shikuar se a eshte numer cift apo tek
		mfhi $t3									# Mbetjen e ruajme tek $t3
		beq $t3, $zero, even						# Kushti per te pare se a eshte mbetja e barabarte me zero per te treguar se eshte cift, nese mbetja eshte 0 kcejme tek even, nese jo vazhdojme tek labela continue

continue:
		addi $t2, $t2, 1   							# Rrisim counterin per 1
		addi $a1, $a1, 4							# Rrisim i ose iteratorin e vargut per 4bytes dmth shkojme tek anetari i radhes
		j loop										# Kercejme prap tek loop

even:	
		li $v0, 1 									# Bejme shtypjen e anetarit te vargut i cili eshte numer cift
		la $a0, ($s1)
		syscall
		li $v0, 4 									# Shtypim nje new line
		la $a0, newLine
		syscall
		j continue									# Bejme jump tek continue pasi kemi printuar anetarin cift te vargut

end:												# Fundi apo mbarimi i programit
		li $v0, 10
		syscall

.data														# deklarimi i data - ketu deklarojme emrat e variablave të përdorur në program
		numbers: .word 7, 5, 6, 12, 35, 27					# deklarimi i vargut 'numbers'
		textOutput: .asciiz "The even numbers are: "		# variabla textOuput qe permban nje string te cilin e kam perdorur per t'u printuar para shfaqjes se numrave çift
		size: .word 6 										# variabla size qe ka vleren 6
		newLine: .asciiz ",\n"								# variabla textOuput qe permban nje string te cilin e kam perdorur per presje dhe per te shkruar ne nje rresht te ri
