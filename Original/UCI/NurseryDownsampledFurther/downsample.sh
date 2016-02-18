#!/bin/bash

original_class_data="nursery.csv"
original_class_tenth_data="nursery_tenth.csv"
original_class_tenth_data_labels="nursery_labels.csv"
original_class_tenth_data_nolabels="nursery_nolabels.csv"
original_class_tenth_data_labels_n="nursery_labels_n.csv"
original_class_tenth_data_nolabels_n="nursery_nolabels_n.csv"
original_class_tenth_data_downsampled_further_n="nursery_downsampled_further_n.csv"
original_class_tenth_data_downsampled_further_sorted_n="nursery_downsampled_further_sorted_n.csv"
original_class_tenth_data_downsampled_further_sorted="nursery_downsampled_further_sorted.csv"
original_class_tenth_data_downsampled_further_sorted_uniq="nursery_downsampled_further_sorted_uniq.csv"
original_class_tenth_data_downsampled_further_sorted_dup="nursery_downsampled_further_sorted_dup.csv"
original_class_tenth_data_downsampled_further_sorted_uniq_real="nursery_downsampled_further_sorted_uniq_real.csv"
original_class_tenth_data_downsampled_further="nursery_downsampled_further.csv"
awk_sh="rm_dup.awk"

# randomly pick ten percent of the whole share.
count="$(wc -l $original_class_data | awk '{print($1)-1}')"
tenPercent=$((1*$count/10))
shuf -n $tenPercent $original_class_data > $original_class_tenth_data

# separate the labels from the rest of the data.
cut -d"," -f 9 $original_class_tenth_data > $original_class_tenth_data_labels
cut -d"," -f 1-8 $original_class_tenth_data > $original_class_tenth_data_nolabels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_tenth_data_labels > $original_class_tenth_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_tenth_data_nolabels > $original_class_tenth_data_nolabels_n

# downsample the domains.
# downsample the 3rd column (HasNurs).
awk -F"," -vOFS="," '{ gsub(/^very_crit$/, "critical",   $3) }1' $original_class_tenth_data_nolabels_n > tmp && mv tmp $original_class_tenth_data_nolabels_n

# join back, sort, remove the first column, and uniq it
join -t, $original_class_tenth_data_nolabels_n $original_class_tenth_data_labels_n -a 1 -o auto -e 'no match' > $original_class_tenth_data_downsampled_further_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 -k7,7 -k8,8 -k9,9 \
	$original_class_tenth_data_downsampled_further_n > $original_class_tenth_data_downsampled_further_sorted_n
cut -d"," -f 2- $original_class_tenth_data_downsampled_further_sorted_n > $original_class_tenth_data_downsampled_further_sorted
uniq $original_class_tenth_data_downsampled_further_sorted > $original_class_tenth_data_downsampled_further_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,spec_prior$/;spec_prior/g' $original_class_tenth_data_downsampled_further_sorted_uniq
sed -i 's/,priority$/;priority/g'     $original_class_tenth_data_downsampled_further_sorted_uniq
sed -i 's/,very_recom$/;very_recom/g' $original_class_tenth_data_downsampled_further_sorted_uniq
sed -i 's/,recommend$/;recommend/g'   $original_class_tenth_data_downsampled_further_sorted_uniq
sed -i 's/,not_recom$/;not_recom/g'   $original_class_tenth_data_downsampled_further_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_tenth_data_downsampled_further_sorted_uniq > $original_class_tenth_data_downsampled_further_sorted_dup
grep -v -x -f $original_class_tenth_data_downsampled_further_sorted_dup $original_class_tenth_data_downsampled_further_sorted_uniq \
	> $original_class_tenth_data_downsampled_further_sorted_uniq_real

# change label back to "1" for good and "2" for bad.
cp $original_class_tenth_data_downsampled_further_sorted_uniq_real $original_class_tenth_data_downsampled_further
sed -i 's/;spec_prior$/,spec_prior/g' $original_class_tenth_data_downsampled_further
sed -i 's/;priority$/,priority/g'     $original_class_tenth_data_downsampled_further
sed -i 's/;very_recom$/,very_recom/g' $original_class_tenth_data_downsampled_further
sed -i 's/;recommend$/,recommend/g'   $original_class_tenth_data_downsampled_further
sed -i 's/;not_recom$/,not_recom/g'   $original_class_tenth_data_downsampled_further

# remove intermediate files
rm $original_class_tenth_data_labels
rm $original_class_tenth_data_nolabels
rm $original_class_tenth_data_labels_n
rm $original_class_tenth_data_nolabels_n
rm $original_class_tenth_data_downsampled_further_n
rm $original_class_tenth_data_downsampled_further_sorted_n
rm $original_class_tenth_data_downsampled_further_sorted
rm $original_class_tenth_data_downsampled_further_sorted_uniq
rm $original_class_tenth_data_downsampled_further_sorted_dup
rm $original_class_tenth_data_downsampled_further_sorted_uniq_real
