tv() { 
# tv: 't'sv 'v'iewer
# usage: tv filename.tsv
# - show 10 less columns than $COLUMNS to overlap one or two characters when scrolling horizontally
# - `cut` is used to remove anything after 2048 column since `column` cannot handle more than that
cat $1 | cut -c 1-2047 | sed ':x s/\(^\|\t\)\t/\1 \t/; t x' | column -t -s $'\t' | less -#$(($COLUMNS-10)) -N -S; 
}

tvwo() {
# tsv viewer without the specified pattern. 
# usage: tvwo pattern_to_remove file.tsv
cat $2 | sed "s/$1//g" | tv;
}

tvs() {
# 't'sv 'v'iewer with 's'implified variable name
# this function will simplify the variable names by removing tablename from tablename.varname.
# Usage: tvs filename.tsv
firstvarname=$(cat $1 | head -n1 | cut -f1);
if [[ $firstvarname =~ \. ]]; then
    tablename=$(echo $firstvarname | grep -oE '^[^\.]+\.'); 
    tvwo $tablename $1;
else
    tv $1;
fi
}

