/*
 * main.c
 * 
 * Copyright 2017 Maxime <chevamax@maxime-Satellite-Pro-R50-B>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */


#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <time.h>


#define OUTPUT_DIRECTORY "data/chevamax"
#define OUTPUT_FILE OUTPUT_DIRECTORY"/measurement"
#define TAILLE 17

long int TAB[TAILLE]= { 10, 50, 100, 500, 1000, 5000, 10000, 50000, 100000, 500000, 1000000, 5000000, 7000000 ,10000000, 15000000 ,25000000};
int TABRep[TAILLE]={ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int REP=5;

char chaine[512];
//char outputFile[] = "data/`hostname`_`date +%F`/measurements_`date +%R`.txt";
//char outputDirectory[] = "data/`hostname`_`date +%F`";

int testFin(){
	
	
	int i;
	for(i=0; i < TAILLE; i++){
		if(TABRep[i] < REP)
			return 0;
	}
	return 1;
}

int main(int argc, char **argv)
{
	time_t rawtime;
	struct tm timeinfo;

	rawtime = time ( NULL );
	timeinfo = *localtime ( &rawtime );
	
	char s_now[sizeof "JJ-MM-AAAA--HH:MM "];
	
	strftime(s_now, sizeof s_now, "%d-%m-%Y--%H:%M", &timeinfo);
	
	sprintf(chaine, "touch "OUTPUT_FILE"%s.txt", s_now);
	
	system("mkdir -p "OUTPUT_DIRECTORY);
	system(chaine);
    
	int size;
	while (!testFin()){
			size= rand() % TAILLE;
			
			while (TABRep[size] >= REP){
				size= rand() % TAILLE;
				printf("rand\n");
			}
			
			TABRep[size] += 1;
			
			sprintf(chaine, "echo Size: %li >> "OUTPUT_FILE"%s.txt", TAB[size], s_now);
			system(chaine);
			
			sprintf(chaine, "./src/parallelQuicksort0 %li >> "OUTPUT_FILE"%s.txt", TAB[size], s_now);
			system(chaine);
			
			sprintf(chaine, "./src/parallelQuicksort1 %li >> "OUTPUT_FILE"%s.txt", TAB[size], s_now);
			system(chaine);
			
			sprintf(chaine, "./src/parallelQuicksort2 %li >> "OUTPUT_FILE"%s.txt", TAB[size], s_now);
			system(chaine);
			
			sprintf(chaine, "./src/parallelQuicksort3 %li >> "OUTPUT_FILE"%s.txt", TAB[size], s_now);
			system(chaine);
	}
	
	//Traitement du fichier pour analyse
	
	sprintf(chaine, "perl scripts/csv_quicksort_extractor3.pl < "OUTPUT_FILE"%s.txt > "OUTPUT_FILE"%s_wide.csv", s_now, s_now);
    system(chaine);
    
    
	
	return 0;
}

