#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    FILE* fichier = NULL;
    int NbCaracLigne = 100;
    int NbLignesPage = 20;
    int caractereActuel = 0;
    int lastCaracter = 0;

    int NbLignes = 0;
    int NbPages = 1;
    int NbPhrases = 0;
    int NbMots = 0;

    int TempLigne = 0;
    int TempPage = 0;


    fichier = fopen("Marseillaise.txt", "r");

    if (fichier != NULL)
    {
        while (caractereActuel != EOF)          // Boucle de lecture des caractères un à un
        {
            caractereActuel = fgetc(fichier);   // On lit le caractère

            if ((caractereActuel=='\n')||(TempLigne==NbCaracLigne))     //Compteur de lignes
            {
                NbLignes+=1;
                TempLigne=0;
                TempPage+=1;
            }

            if (TempPage==NbLignesPage)                                 //Compteur de pages
            {
                NbPages+=1;
                TempPage=0;
            }

            if ((caractereActuel=='.')||(caractereActuel=='!')||(caractereActuel=='?'))     //Compteur de phrases
            {
                NbPhrases+=1;
            }

            if ((caractereActuel=='.')||(caractereActuel==' ')||(caractereActuel=='\n'))    //Compteur de mots
            {
                if ((caractereActuel=='\n'))
                {
                    if ((lastCaracter!='?')&&(lastCaracter!='!')&&(lastCaracter!='\n'))
                                                            //attention quand on saute une ligne ne pas confondre le dernier caratere
                    {
                        NbMots+=1;
                    }
                }
                else if ((lastCaracter!='!')&&(lastCaracter!='?')&&(lastCaracter!=' ')&&(lastCaracter!=';'))    // '!' '?' ';'' ' ' ne sont pas des mots 
                {
                    NbMots+=1;
                }
            }
            //printf("%c ---mot %d\n", caractereActuel,NbMots);

            lastCaracter=caractereActuel;

        } // On continue tant que fgetc n'a pas retourné EOF (fin de fichier)

        NbLignes+=1;    //Pour compter la derniere ligne    40

        fclose(fichier);

        printf("Le fichier a %d lignes.\nEt il a %d pages.\nEt il a %d phrases\nEt il a %d mots.\n", NbLignes, NbPages, NbPhrases,NbMots);
    }



    return 0;
}