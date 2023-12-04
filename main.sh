#!bin/bash

begin (){
  echo "----------------------------------------------"
  echo "Sveiki atvyke i valstybiu ir sostiniu zaidima!"
  echo "----------------------------------------------"
}

random(){
   num_lines=$(wc -l < countries.csv)

   random=$((1 + RANDOM % num_lines))
}

meniu (){
  
  while :
  do
    echo "1. Speti sostine pagal valstybe"
    echo "2. Speti valstybe pagal sostine"
    echo "3. Rodyti taskus"
    echo "4. Baigti zaidima"
    
    read -p "Jusu pasirinkimas:" choose

    case $choose in
      "1") random
           
           awk -v line="$random" -F',' 'NR==line {gsub(/"/, "", $1); print $1}' countries.csv
           
           random_sostine=$(awk -v line="$random" -F',' 'NR==line {gsub(/"/, "", $2); print $2}' countries.csv)
           
           read -p "Iveskite sostines pavadinima:" answer
           
           if [[ $answer == $random_sostine ]]
           then 
           printf "\nJusu atsakymas teisingas!\nGaunate +1 taska.\n\n"
           ((points++))
           echo "$points" > points.txt
           
           else printf "\nJusu atsakymas neteisingas!\nBandykite dar karta.\n\n"
           fi  
           ;;
      
      "2") random

          awk -v line="$random" -F',' 'NR==line {gsub(/"/, "", $2); print $2}' countries.csv
          
          random_valstybe=$(awk -v line="$random" -F',' 'NR==line {gsub(/"/, "", $1); print $1}' countries.csv)

          read -p "Iveskite valstybes pavadinima:" answer

          if [[ $answer == $random_valstybe ]]
          then 
          printf "\nJusu atsakymas teisingas!\nGaunate +1 taska.\n\n"
          ((points++))
          echo "$points" > points.txt
          
          else printf "\nJusu atsakymas neteisingas!\nBandykite dar karta.\n\n"
          fi 
          ;;

      "3") printf "\nJusu taskai: "
          cat points.txt
          printf "\n"
          ;;
      "4") break;;
          esac
  done
}

begin
meniu
