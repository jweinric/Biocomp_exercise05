# Takes unique gender-yearsExperience combos in wages.csv, sorts by gender 
# then number, inputs two columns into new space delimited file
# Usage: from directory with wages.csv, bash task1.sh

for file in wages.csv
do
cat $file | cut -d , -f 1,2 | grep -v "gender" | tr "," " " | sort -k1,1 -k2,2g | uniq > gender-yearsExperience.txt
echo "top earner: gender, years experience, wage"
cat $file | tr "," " " | grep -v "gender" | sort -k4,4g | tail -n 1 | cut -d " " -f 1,2,4
echo "bottom earner: gender, years experience, wage"
cat $file | tr "," " " | grep -v "gender" | sort -k4,4g | head -n 1 | cut -d " " -f 1,2,4
echo "# of females in top 10 earners"
cat $file | tr "," " " | grep -v "gender" | sort -k4,4g | tail -n 10 | grep "female" | wc -l
echo "difference between minimum wage for college grads vs non college grads"
grad=$(cat $file | grep -E "[a-z]+,[0-9]{1,2},16,[1-9].[1-9]+" | cut -d , -f 4 | sort -g | head -n 1)
nograd=$(cat $file | grep -E "[a-z]+,[0-9]{1,2},12,[1-9].[1-9]+" | cut -d , -f 4 | sort -g | head -n 1)
echo "$grad - $nograd" | bc
done

