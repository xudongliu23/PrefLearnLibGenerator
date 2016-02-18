#!/bin/bash

original_class_data="discrete_wine.csv"
original_class_data_labels="discrete_wine_labels.csv"
original_class_data_nolabels="discrete_wine_nolabels.csv"
original_class_data_labels_n="discrete_wine_labels_n.csv"
original_class_data_nolabels_n="discrete_wine_nolabels_n.csv"
original_class_data_nolabels_n_downsampled_further="discrete_wine_nolabels_n_downsampled_further.csv"
original_class_data_downsampled_n="discrete_wine_downsampled_n.csv"
original_class_data_downsampled_sorted_n="discrete_wine_downsampled_sorted_n.csv"
original_class_data_downsampled_sorted="discrete_wine_downsampled_sorted.csv"
original_class_data_downsampled_sorted_uniq="discrete_wine_downsampled_sorted_uniq.csv"
original_class_data_downsampled_sorted_dup="discrete_wine_downsampled_sorted_dup.csv"
original_class_data_downsampled_sorted_uniq_real="discrete_wine_downsampled_sorted_uniq_real.csv"
original_class_data_downsampled_further="discrete_wine_downsampled_further.csv"
awk_sh="rm_dup.awk"

# separate the labels from the rest of the data.
cut -d"," -f 1-13 $original_class_data > $original_class_data_nolabels
cut -d"," -f 14 $original_class_data > $original_class_data_labels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_labels > $original_class_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_nolabels > $original_class_data_nolabels_n

# downsample the domains.
cut -d"," -f 1-11 $original_class_data_nolabels_n > $original_class_data_nolabels_n_downsampled_further

# rename the labels
sed -i 's/,1$/,bad/g' $original_class_data_labels_n
sed -i 's/,2$/,good/g' $original_class_data_labels_n
sed -i 's/,3$/,vgood/g' $original_class_data_labels_n

# join back, sort, remove the first column, and uniq it
join -t, $original_class_data_nolabels_n_downsampled_further $original_class_data_labels_n -a 1 -o auto -e 'no match' > $original_class_data_downsampled_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 -k7,7 -k8,8 -k9,9 -k10,10 -k11,11 \
	$original_class_data_downsampled_n > $original_class_data_downsampled_sorted_n
cut -d"," -f 2- $original_class_data_downsampled_sorted_n > $original_class_data_downsampled_sorted
uniq $original_class_data_downsampled_sorted > $original_class_data_downsampled_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,bad$/;bad/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,good$/;good/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,vgood$/;vgood/g' $original_class_data_downsampled_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_data_downsampled_sorted_uniq > $original_class_data_downsampled_sorted_dup
grep -v -x -f $original_class_data_downsampled_sorted_dup $original_class_data_downsampled_sorted_uniq \
	> $original_class_data_downsampled_sorted_uniq_real

# change label back to "0" for normal and "1" for abnormal.
cp $original_class_data_downsampled_sorted_uniq_real $original_class_data_downsampled_further
sed -i 's/;bad$/,1/g' $original_class_data_downsampled_further
sed -i 's/;good$/,2/g' $original_class_data_downsampled_further
sed -i 's/;vgood$/,3/g' $original_class_data_downsampled_further

# remove intermediate files
rm $original_class_data_labels
rm $original_class_data_nolabels
rm $original_class_data_labels_n
rm $original_class_data_nolabels_n
rm $original_class_data_nolabels_n_downsampled_further
rm $original_class_data_downsampled_n
rm $original_class_data_downsampled_sorted_n
rm $original_class_data_downsampled_sorted
rm $original_class_data_downsampled_sorted_uniq
rm $original_class_data_downsampled_sorted_dup
rm $original_class_data_downsampled_sorted_uniq_real
