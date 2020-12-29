.data
erreur_ouverture_fichier:	.asciiz "erreur ouverture fichier\n"
success_ouverture_fichier:	.asciiz "succès ouverture fichier\n"
nbr_de_phrases:			.asciiz "le nombre de phrase est: "
nbr_de_lignes:			.asciiz "le nombre de lignes est: "
nbr_de_pages:			.asciiz "le nombre de pages est: "
saut_de_ligne:			.asciiz "\n"

nbr_lignes_dans_page:		.word 6

chemin_texte:                	.asciiz "test.txt"
buffer:				.space 1
tab_resultat_f2:		.word 0, 0, 0

# $t6 tab
# $a1 caractere actuelle
# $s1 utiliser pour phrases
# $s2 utiliser pour lignes

    .text
main:
	subu $sp,$sp,8    	#prologue
	sw $fp,4($sp)
	addi $fp,$sp,8

    	li  $v0, 13            	 #open file
        la  $a0, chemin_texte  	 # file path
        li  $a1,0        	 #lecture =0 (flag)
        li  $a2,0        	 # = 0 (mode : reading from standard input)
        syscall        		 #ouverture du fichier
	move $s6, $v0      	 #adresse fichier 
	
        #si erreur d'ouverture du fichier
        bltz $v0,erreur_ouverture 		# erreur_ouverture
        la $a0,success_ouverture_fichier	# charge le texte
   	ori $v0,$zero,4				# 4 affichage texte
        syscall
        
        la $t6,tab_resultat_f2			# chargement du tableau pour resultat
               
        
        jal f1_lecture_caractere 		# appel fonction
                             
  
        lw $fp,4($sp)				#FIN
	addu $sp,$sp,8
	
			
        j fin_programme

erreur_ouverture:

    la $a0,erreur_ouverture_fichier
    ori $v0,$zero,4
        syscall

fin_programme:
	li   $v0, 16       # 16 pour fermer le fichier
  	move $a0, $s6      # adresse fichier dans $a0 pour fermeture
  	syscall            # fermeture

        ori $v0,$zero,10	#sortie
        syscall
        
f1_lecture_caractere:  			#lecture du fichier caractère par caractère	
        subu $sp,$sp,12    		#prologue
	sw $fp,4($sp)
	sw $ra,8($sp)
	addu $fp,$sp,12
	
lecture_caractere_f1:
        li $v0,14			#code service lecture fichier
        #chargement des paramètres
        ori $a0,$s6,0			#adresse fichier
        la $a1,buffer			#adresse buffer
        
        ori $a2,$zero,1			#nombre de caractère lue
        syscall
        ori $s0,$v0,0			#si V0= 0 => fin fichier
        
        beq $s0,$zero,fin_programme_f1	#on sort si c'est le dernier caractère
        
  	
  	
  	
        jal f2_compteur_phrase
        
	jal f3_compteur_ligne
	
	
        
        ori $a0,$a1,0			#affichage du caractère
        ori $v0,$zero,4
        syscall
        
        ori $a0,$zero,0x20		#affichage espace
        ori $v0,$zero,11
        syscall
        
        j lecture_caractere_f1 		#on refait un tour de boucle
        
        
        
        
	
fin_programme_f1:	

	#affichage des valeurs
	la $a0,saut_de_ligne		#afficher saut de ligne
    	ori $v0,$zero,4
        syscall	
		
	la $a0,nbr_de_phrases		#afficher le texte nbr phrases
    	ori $v0,$zero,4
        syscall
        
	lw $t6,0($t6)			# affichage du tab_resultat
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall
	
	la $a0,saut_de_ligne		#afficher saut de ligne
    	ori $v0,$zero,4
        syscall
	
	la $a0,nbr_de_lignes		#afficher le texte nbr lignes
    	ori $v0,$zero,4
        syscall
	
	la $t6,tab_resultat_f2		# chargement du tableau pour resultat
	lw $t6,4($t6)			# affichage du tab_resultat le 2
	ori $a0,$t6,0
	ori $v0,$zero,1
	syscall
	
	la $a0,saut_de_ligne		#afficher saut de ligne
    	ori $v0,$zero,4
        syscall
        
        #calcule et affichage nbr pages
        la $a0,nbr_de_pages		#affiche message pages
    	ori $v0,$zero,4
        syscall
        
        la $t6,tab_resultat_f2		#div de nbr de ligne pour trouver le nombre de page aroundi
        lw $t6,4($t6)
        la $t7,nbr_lignes_dans_page
        lw $t7,0($t7)
        div $t6,$t7
        mflo $t5
        
        lui $t4,10			#multiplier par 10 le nombre de ligne
        mult $t4,$t6
        mflo $t3
        
        div $t3,$t7			#puis diviser par le nombre de lignes par page 
        mflo $t3
        
        mult $t5,$t4			# multiplier le nombre de page arondi par 10
        mflo $t4
                
        beq $t4,$t3,fin_page_plus_zero	#comparer les deux valeurs equivalent a voir si la division a un reste
  
        addi $a0,$t5,1			#afficher nbr pages +1 si il ya un reste 
	ori $v0,$zero,1
	syscall
        
	j fin_f_page
	
fin_page_plus_zero:
	addi $a0,$t5,0			#afficher nbr pages normalement si pas de reste
	ori $v0,$zero,1
	syscall
	
	j fin_f_page
	
fin_f_page:




	lw $ra,8($sp)			#EPILOGUE
	lw $fp,4($sp)
	addu $sp,$sp,12
	
	jr $ra


#---------------------------
f2_compteur_phrase:
	subu $sp,$sp,8   		#prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	ori $t0,$zero,0x21		# caract '!'
	ori $t1,$zero,0x2E		# caract '.'
	ori $t2,$zero,0x3F		# caract '?'
	
	lb $s5,0($a1)			#important
	
	beq $s5,$t0,compteur_phrase_f2	 #si ='!'
	beq $s5,$t1,compteur_phrase_f2 	#si ='.'
	beq $s5,$t2,compteur_phrase_f2	#si ='?'
	
	j fin_programme_f2	
	
compteur_phrase_f2:
	addi $s1,$s1,1
	
fin_programme_f2:		#EPILOGUE
	lw $fp,4($sp)
	addu $sp,$sp,8

	sw $s1,0($t6)			# on écrit dans le tab_resultat
	
	jr $ra
	
#----------------------
f3_compteur_ligne:
	subu $sp,$sp,8   		#prologue
	sw $fp,4($sp)
	addu $fp,$sp,8
	
	ori $t0,$zero,0x0A		# saut de ligne '\n'
	
	lb $s5,0($a1)			#important
	
	beq $s5,$t0,compteur_ligne_f3	 #si ='\n'

	j fin_programme_f3	
	
compteur_ligne_f3:
	addi $s2,$s2,1
	
fin_programme_f3:		#EPILOGUE
	lw $fp,4($sp)
	addu $sp,$sp,8

	sw $s2,4($t6)		# on écrit dans le tab_resultat
	
	jr $ra
	
#--------------------------

