#!/bin/bash
### usage: run shell script in source_content directory. 
### EX: sh ../dir_fix.sh 
### enter prompts to appropriately LN

#specifcy the path for the new plex location;
#I have two directories, one TV and one MOVIE
#using tv_dir for shows and mov_dir for movies

#source_content is where we are linking from.
#this contains a mix of movies and shows. 

tv_dir='/home/howle/Shows'
mov_dir='/home/howle/Movies'

#source_content='/home/howle/files'
#frees up read for user input
exec 3<> /dev/stdin

#replace spaces with . for directorie names in pwd
#doesn't seem to have impact on my seedbox file structure. 
#use w/ caution - The adjustment is verbose so you can undo what was done. Safety file output = ~/plex-dir-moves.txt
for d in *\ *; do mv -v "$d" "${d// /.}" | tee ~/plex-dir-moves.txt ; done

ls | while read LINE ; do
    read -u 3 -p "is $LINE a movie or TV show? t/m: (skip w/ any other character) " tm
    case $tm in
        [Tt]* ) ln -s $LINE $tv_dir && ls -la $tv_dir ; ;;
        [Mm]* ) ln -s $LINE $mov_dir && ls -la $mov_dir ; ;; 
        * ) echo "Skipping - (yY|nN) required to create symbolic link ";;
    esac
done
