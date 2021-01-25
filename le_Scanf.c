#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char const *argv[])
{

	int caractereActuel =0;
	int lastcaratere =0;
	int loop=0;

	FILE* fichier = NULL;

    fichier = fopen("test.txt", "r");

    int TabInt[10] = {0};

    char temp0[28]={0};
    char temp1[28]={0};
    char temp2[28]={0};
    char temp3[28]={0};
    char temp4[28]={0};
    char temp5[28]={0};
    char temp6[28]={0};
    char temp7[28]={0};
    char temp8[28]={0};
    char temp9[28]={0};

    char* TabChar[10] = {temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9};

    char temp[28]={0};

    int tour = 0;
    int existe = 0;
    int min=99;
    int indiceMin;
   // char end[28]= "\0";

    if (fichier == NULL){
        printf("YOUSK2\n");
    }
    
        
        //while(caractereActuel != EOF)
        for (int irr = 0; irr < 40; ++irr)
        {
            //fscanf(fichier,"%s",temp);
            for (int i2 = 0; i2 < 28; ++i2){
            	temp[i2]=0;
            }
            loop=0;
            lastcaratere=fgetc(fichier);
            while((lastcaratere!='.')&&(lastcaratere!='!')&&(lastcaratere!='?')&&(lastcaratere!=' ')&&(lastcaratere!='\n')&&(lastcaratere!=',')){
            	caractereActuel = fgetc(fichier);
            	temp[loop] = lastcaratere;
            	lastcaratere = caractereActuel;
            	loop++;
                printf("gogo %c etaiit %c\n",temp[loop],lastcaratere);
            }
            
            printf("pass scan\n");
            for (int i = 0; i < 10; ++i)
            {
                if (strcmp( temp, TabChar[i] ) == 0)
                {
                    TabInt[i] ++;
                    existe = 1;
                }
            }
            printf("pass strcmp\n");
            if (existe == 0)
            {
                for (int j = 0; j < 10; ++j)
                 {
                    if (TabInt[j] < min )
                    {
                        min = TabInt[j];
                        indiceMin = j;
                    }
                 }
                 //TabChar[min] = temp;
                 strcpy(TabChar[indiceMin],temp);
                 TabInt[indiceMin] = 1;
                
            }

            existe = 0;
            tour++;
            min =99;
        }
        printf("goooood\n");
        for (int i = 0; i < 10; ++i)
        {
            printf("%d de %s \n",TabInt[i] ,TabChar[i]);
        }

    fclose(fichier);
	return 0;
}
