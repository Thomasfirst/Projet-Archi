.data
erreur_ouverture_fichier:	.asciiz "erreur ouverture fichier\n"
erreur_ouverture_fichier2:	.asciiz "\nerreur ouverture fichier partie 2\n"
success_ouverture_fichier:	.asciiz "succès ouverture fichier\n"
success_ouverture_fichier2:	.asciiz "\nsuccès ouverture fichier partie 2\n"
nbr_de_phrases:			.asciiz "le nombre de phrase est: "
nbr_mots:			.asciiz "le nombre de mot est: "
nbr_de_lignes:			.asciiz "le nombre de lignes est: "
nbr_de_pages:			.asciiz "le nombre de pages est: "
il_y_a:				.asciiz "Il y a  "
nbr_lignes_dans_page:		.word 5

chemin_texte:                	.asciiz "/home/polytech/Bureau/Info/TParchi/Projet/Projet-Archi/Marseillaise.txt"
chemin_texte2:                	.asciiz "/home/polytech/Bureau/Info/TParchi/Projet/Projet-Archi/Marseillaise.txt"
buffer:				.space 1
tab_resultat_fonction:		.word 0,0,0,0

#variables fonction fréquence mot
caractereActuel:		.word 0
lastcaratere:			.word 0
loop:				.word 0
#nombre de répétitons des mots les plus fréquents associés à leur position dans TabChar
TabInt:				.word 0,0,0,0,0,0,0,0,0,0
#tableau de taille 28 pour sauvegarder les mots les plus fréquents
temp0			:	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp1:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp2:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp3:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp4:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp5:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp6:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp7:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp8:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp9:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
#char* TabChar[10] = {temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9};
temp:				.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp_char:			.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
temp_int:			.word 0
#tour:				.word 0
existe:				.word 0
min:				.word 999
indiceMin:			.word 0
comp:				.word 0
freq_lettre:			.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .text
main:
	subu $sp,$sp,8    			# prologue
	sw $fp,4($sp)
	addi $fp,$sp,8
	
    	li  $v0, 13            	 		# syscall pour l'ouverture du fichier
        la  $a0, chemin_texte  			# chemin du fichier
        li  $a1,0        	 		# lecture = 0 (flag)
        li  $a2,0        	 		# = 0 (mode : reading from standard input)
        syscall        		 		# ouverture du fichier
	move $s6, $v0      			# sauvegarde adresse fichier 
	
        # erreur d'ouverture du fichier si $vo est négatif
        bltz $v0,erreur_ouverture_part1		# redirection fin du programme
        la $a0,success_ouverture_fichier	# affichage du texte
   	ori $v0,$zero,4				
        syscall
        
        la $t6,tab_resultat_fonction		# chargement du tableau pour resultat fonction
        
        ori $s7,$zero,0				# var "caractère_précédent" de la fonction nb_mot initialisé à 0
        
        jal f1_lecture_caractere 		# appel fonction 
  

        j fin_programme_part1

	erreur_ouverture_part1:	
	la $a0,erreur_ouverture_fichier		# affichage du texte
	ori $v0,$zero,4				
        syscall

	fin_programme_part1:
	li   $v0, 16       			# syscall pour fermer le fichier
  	move $a0, $s6      			# adresse fichier dans $a0 pour fermeture
  	syscall            			# fermeture
  	
  	
	# On répète la procédure d'ouverture et de fermeture du fichier afin de lancer la fonction fréquence mot  	
  	li  $v0, 13            	 		# syscall pour l'ouverture du fichier
        la  $a0,chemin_texte2  			# chemin du fichier
        li  $a1,0        	 		# lecture = 0 (flag)
        li  $a2,0        	 		# = 0 (mode : reading from standard input)
        syscall        		 		# ouverture du fichier
	move $s6, $v0      			# sauvegarde adresse fichier 
	

        
        j fin_programme_part2

	erreur_ouverture_part2:	
	la $a0,erreur_ouverture_fichier2	# affichage du texte
	ori $v0,$zero,4				
        syscall

	fin_programme_part2:
	li   $v0, 16       			# syscall pour fermer le fichier
  	move $a0, $s6      			# adresse fichier dans $a0 pour fermeture
  	syscall            			# fermeture
  	

	lw $fp,4($sp)				# fin de l'appel de la fonction main
	addu $sp,$sp,8
	
        ori $v0,$zero,10			# sortie du programme
        syscall
        
        
f1_lecture_caractere:  				# lecture du fichier caractère par caractère 	
        subu $sp,$sp,12    			# prologue
	sw $fp,4($sp)
	sw $ra,8($sp)
	addu $fp,$sp,12
	
	lecture_caractere_f1:
        li $v0,14				# code service lecture fichier
        
        #chargement des paramètres
        ori $a0,$s6,0				# adresse fichier
        la $a1,buffer				# adresse buffer
        ori $a2,$zero,1				# nombre de caractère lue
        syscall
        
        ori $s0,$v0,0				# si V0= 0 => fin du fichier
        beq $s0,$zero,fin_programme_f1		# on sort si c'est le dernier caractère
        
        jal f2_compteur_phrase			
        jal f3_compteur_mot			
        jal f4_compteur_ligne
        jal f7_freq_lettres
	
	#----si on veut afficher les caractere du texte ,il faut decommenter
        ori $a0,$a1,0				# affichage du caractère
        ori $v0,$zero,4
        syscall
        
        j lecture_caractere_f1 			# on refait un tour de boucle
	
	fin_programme_f1:	
		
	jal f5_compteur_page	
	jal f6_affichage_resultat
	
	lw $ra,8($sp)				# epilogue
	lw $fp,4($sp)
	addu $sp,$sp,12
	
	jr $ra
	
f2_compteur_phrase:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	ori $t0,$zero,0x21			# caract '!'
	ori $t1,$zero,0x2E			# caract '.'
	ori $t2,$zero,0x3F			# caract '?'
	
	lb $s5,0($a1)				# on récupoère le caractère lu
	
	beq $s5,$t0,compteur_phrase_f2	 	# si = '!'
	beq $s5,$t1,compteur_phrase_f2 		# si = '.'
	beq $s5,$t2,compteur_phrase_f2		# si = '?'
	j fin_programme_f2	
	
	compteur_phrase_f2:			# nb phrase + 1
	addi $s1,$s1,1
	
	fin_programme_f2:			# epilogue
	lw $fp,4($sp)
	addu $sp,$sp,8
	
	sw $s1,0($t6)				# on écrit dans le tab_resultat
	
	jr $ra

f3_compteur_mot:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8

	ori $t0,$zero,0x21			# caract '!'
	ori $t1,$zero,0x2E			# caract '.'
	ori $t2,$zero,0x3F			# caract '?'
	ori $t3,$zero,0x20			# caract ' '
	ori $t4,$zero,0x2C			# caract ','
	ori $t5,$zero,0x3B			# caract ';'
	ori $t7,$zero,0x0A			# caract '\n'
	
	lb $s5,0($a1)				# on récupère le caractère lu
	
	beq $s5,$t1,compteur_mot_1_f3 		# if == '.'
	beq $s5,$t3,compteur_mot_1_f3		# if == ' '
	beq $s5,$t7,compteur_mot_1_f3		# if == '\n'
	beq $s5,$t4,compteur_mot_1_f3		# if == ','
	j fin_programme_f3			# sinon on sort du programme
	
	compteur_mot_1_f3:			# comparaison avec $s7 = caractère_précédent
	beq $s7,$t2,fin_programme_f3		# if == '?'
	beq $s7,$t0,fin_programme_f3		# if == '!'
	beq $s7,$t7,fin_programme_f3		# if == '\n'
	beq $s7,$t1,fin_programme_f3		# if == '.'
	beq $s7,$t4,fin_programme_f3		# if == ','
	beq $s7,$t5,fin_programme_f3		# if == ';'
	beq $s7,$t3,fin_programme_f3		# if == ' '
	
	addi $s2,$s2,1				# NbMots +=1 si caractère_précédent different des caracteres precedent
	j fin_programme_f3
	
	
	fin_programme_f3:			# epilogue
	
	ori $s7,$s5,0				# caractère_précédent = caractere_Actuel
	sw $s2,4($t6)				# on écrit dans le tab_resultat
	lw $fp,4($sp)
	addu $sp,$sp,8
	jr $ra
	
f4_compteur_ligne:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	ori $t0,$zero,0x0A			# saut de ligne '\n'
	
	lb $s5,0($a1)				# on récupoère le caractère lu
	
	beq $s5,$t0,compteur_ligne_f4		# si ='\n'
	
	j fin_programme_f4	
	
	compteur_ligne_f4:
	addi $s3,$s3,1
	
	fin_programme_f4:			# epilogue
	
	
	lw $fp,8($sp)
	addu $sp,$sp,8
	sw $s3,8($t6)				# on écrit dans le tab_resultat
	jr $ra
	
f5_compteur_page:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
        lw $t3,8($t6)				# nombre de lignes
        addi $t3,$t3,1				# + une ligne pour conter la premiere ligne
        la $t7,nbr_lignes_dans_page		# nombre de lignes par page 
        lw $t7,0($t7)
        div $t3,$t7				
        mfhi $t5				# reste
 	mflo $t4 				# quotient
        	
        beq $t5,$zero,fin_programme_f5		
       	addi $t4,$t4,1				# +1 page si le reste est non nul


	fin_programme_f5:			# epilogue
	
	lw $fp,4($sp)				
	addu $sp,$sp,8
	sw $t4,12($t6)				# on écrit dans le tab_resultat	
	jr $ra
	
f7_freq_lettres:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	lb $s5,0($a1)				# on récupoère le caractère lu
	
	ori $t0,$zero,0x61			# caractere a 
	ori $t1,$zero,0x41			# caractere A 
	beq $s5,$t0,compteur_freq_a		# si 'a'
	beq $s5,$t1,compteur_freq_a		# si 'A'
	
	ori $t0,$zero,0x62			# caractere b
	ori $t1,$zero,0x42			# caractere B
	beq $s5,$t0,compteur_freq_b
	beq $s5,$t1,compteur_freq_b
	
	ori $t0,$zero,0x63			# caractere c
	ori $t1,$zero,0x43			# caractere C
	beq $s5,$t0,compteur_freq_c
	beq $s5,$t1,compteur_freq_c
	
	ori $t0,$zero,0x64			# caractere d
	ori $t1,$zero,0x44			# caractere D
	beq $s5,$t0,compteur_freq_d
	beq $s5,$t1,compteur_freq_d
	
	ori $t0,$zero,0x65			# caractere e
	ori $t1,$zero,0x45			# caractere E
	beq $s5,$t0,compteur_freq_e
	beq $s5,$t1,compteur_freq_e
	
	ori $t0,$zero,0x66			# caractere f
	ori $t1,$zero,0x46			# caractere F
	beq $s5,$t0,compteur_freq_f
	beq $s5,$t1,compteur_freq_f
	
	ori $t0,$zero,0x67			# caractere g
	ori $t1,$zero,0x47			# caractere G
	beq $s5,$t0,compteur_freq_g
	beq $s5,$t1,compteur_freq_g
	
	ori $t0,$zero,0x68			# caractere h
	ori $t1,$zero,0x48			# caractere H
	beq $s5,$t0,compteur_freq_h
	beq $s5,$t1,compteur_freq_h
	
	ori $t0,$zero,0x69			# caractere i
	ori $t1,$zero,0x49			# caractere I
	beq $s5,$t0,compteur_freq_i
	beq $s5,$t1,compteur_freq_i
	
	ori $t0,$zero,0x6A			# caractere j
	ori $t1,$zero,0x4A			# caractere J
	beq $s5,$t0,compteur_freq_j
	beq $s5,$t1,compteur_freq_j
	
	ori $t0,$zero,0x6B			# caractere k
	ori $t1,$zero,0x4B			# caractere K
	beq $s5,$t0,compteur_freq_k
	beq $s5,$t1,compteur_freq_k
	
	ori $t0,$zero,0x6C			# caractere l
	ori $t1,$zero,0x4C			# caractere L
	beq $s5,$t0,compteur_freq_l
	beq $s5,$t1,compteur_freq_l
	
	ori $t0,$zero,0x6D			# caractere m
	ori $t1,$zero,0x4D			# caractere M
	beq $s5,$t0,compteur_freq_m
	beq $s5,$t1,compteur_freq_m
	
	ori $t0,$zero,0x6E			# caractere n
	ori $t1,$zero,0x4E			# caractere N
	beq $s5,$t0,compteur_freq_n
	beq $s5,$t1,compteur_freq_n
	
	ori $t0,$zero,0x6F			# caractere o
	ori $t1,$zero,0x4F			# caractere O
	beq $s5,$t0,compteur_freq_o
	beq $s5,$t1,compteur_freq_o
	
	ori $t0,$zero,0x70			# caractere p
	ori $t1,$zero,0x50			# caractere P
	beq $s5,$t0,compteur_freq_p
	beq $s5,$t1,compteur_freq_p
	
	ori $t0,$zero,0x71			# caractere q
	ori $t1,$zero,0x51			# caractere Q
	beq $s5,$t0,compteur_freq_q
	beq $s5,$t1,compteur_freq_q
	
	ori $t0,$zero,0x72			# caractere r
	ori $t1,$zero,0x52			# caractere R
	beq $s5,$t0,compteur_freq_r
	beq $s5,$t1,compteur_freq_r
	
	ori $t0,$zero,0x73			# caractere s
	ori $t1,$zero,0x53			# caractere S
	beq $s5,$t0,compteur_freq_s
	beq $s5,$t1,compteur_freq_s
	
	ori $t0,$zero,0x74			# caractere t
	ori $t1,$zero,0x54			# caractere T
	beq $s5,$t0,compteur_freq_t
	beq $s5,$t1,compteur_freq_t
	
	ori $t0,$zero,0x75			# caractere u
	ori $t1,$zero,0x55			# caractere U
	beq $s5,$t0,compteur_freq_u
	beq $s5,$t1,compteur_freq_u
	
	ori $t0,$zero,0x76			# caractere v
	ori $t1,$zero,0x56			# caractere V
	beq $s5,$t0,compteur_freq_v
	beq $s5,$t1,compteur_freq_v
	
	ori $t0,$zero,0x77			# caractere w
	ori $t1,$zero,0x57			# caractere W
	beq $s5,$t0,compteur_freq_w
	beq $s5,$t1,compteur_freq_w
	
	ori $t0,$zero,0x78			# caractere x
	ori $t1,$zero,0x58			# caractere X
	beq $s5,$t0,compteur_freq_x
	beq $s5,$t1,compteur_freq_x
	
	ori $t0,$zero,0x79			# caractere y
	ori $t1,$zero,0x59			# caractere Y
	beq $s5,$t0,compteur_freq_y
	beq $s5,$t1,compteur_freq_y
	
	ori $t0,$zero,0x7A			# caractere z
	ori $t1,$zero,0x5A			# caractere Z
	beq $s5,$t0,compteur_freq_z
	beq $s5,$t1,compteur_freq_z
	
	
	j fin_programme_frq_ltr	
	
	compteur_freq_a:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,0				# charge freqlettre[0]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_b:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,4				# charge freqlettre[1]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_c:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,8				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_d:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,12				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_e:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,16				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_f:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,20				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_g:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,24				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_h:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,28				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_i:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,32				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_j:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,36				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_k:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,40				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_l:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,44				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_m:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,48				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_n:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,52				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_o:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,56				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_p:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,60				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_q:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,64				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_r:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,68				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_s:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,72				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_t:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,76				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_u:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,80				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_v:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,84				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_w:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,88				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_x:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,92				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_y:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,96				# charge freqlettre[2]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	compteur_freq_z:
	la $t3,freq_lettre			# charge adresse de freqlettre
	addi $t3,$t3,100				# charge freqlettre[25]
	lw $t4,0($t3)				# charge valeur de freqlettre
	addi $t4,$t4,1				# ajout de 1 
	sw $t4,0($t3)				# on sauvegarde avec plus un
	j fin_programme_frq_ltr	
	
	fin_programme_frq_ltr:			# epilogue
	
	
	lw $fp,8($sp)
	addu $sp,$sp,8
	jr $ra
		
f6_affichage_resultat:
	subu $sp,$sp,8   			# prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	
		
	la $a0,nbr_de_phrases			# affichage texte nbr phrases
    	ori $v0,$zero,4
        syscall
        
	lw $s3,0($t6)				# affichage du tab_resultat 1
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	
        
	la $a0,nbr_mots				#affichage texte nbr mots
    	ori $v0,$zero,4
        syscall
        
      
	lw $s3,4($t6)				# affichage du tab_resultat 2
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall
	
	la $a0,nbr_de_lignes			#afficher le texte nbr lignes
    	ori $v0,$zero,4
        syscall
	
	
	lw $s3,8($t6)				# affichage du tab_resultat 3
	addi $s3,$s3,1				# + une ligne pour conter la premiere
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
		
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall
        
        #calcule et affichage nbr pages
        la $a0,nbr_de_pages			#affiche message pages
    	ori $v0,$zero,4
        syscall

	lw $s3,12($t6)				# affichage du tab_resultat 4
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	
        
        #----affichage frq lettre 
        la $t6,freq_lettre			# load adresse freq lettres
        
        # a
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,0($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
	
	ori $a0,$zero,0x61			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	
        
         # b
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,4($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x62			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # c
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,8($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x63			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # d
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,12($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x64			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # e
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,16($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x65			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # f
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,20($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x66			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # g
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,24($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x67			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # h
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,28($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x68			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # I
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,32($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x69			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # j
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,36($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x6A			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # k
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,40($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x6B			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # l
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,44($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x6C			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # m
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,48($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x6D			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # n
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,52($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x6E			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # o
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,56($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x6F			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # p
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,60($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x70			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # q
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,64($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x71			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # r
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,68($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x72			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # s
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,72($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x73			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

 # t
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,76($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x74			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

# u
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,80($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x75			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

# v
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,84($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x76			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

# w
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,88($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x77			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

# x
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,92($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x78			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

# y
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,96($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x79			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	

# Z
        la $a0,il_y_a				#affiche message il_y_a
    	ori $v0,$zero,4
        syscall

	lw $s3,100($t6)				# affichage nombre a
	ori $a0,$s3,0
	ori $v0,$zero,1
	syscall
	
	ori $a0,$zero,0x20			# affichage espace
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x7A			# affichage a	
    	ori $v0,$zero,11
        syscall	
        
	ori $a0,$zero,0x0A			# affichage saut de ligne	
    	ori $v0,$zero,11
        syscall	





	lw $fp,4($sp)				# epilogue
	addu $sp,$sp,8
	jr $ra


