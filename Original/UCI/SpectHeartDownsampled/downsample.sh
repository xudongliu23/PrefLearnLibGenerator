#!/bin/bash

original_class_data="spect_heart.csv"
original_class_data_labels="spect_heart_labels.csv"
original_class_data_nolabels="spect_heart_nolabels.csv"
original_class_data_labels_n="spect_heart_labels_n.csv"
original_class_data_nolabels_n="spect_heart_nolabels_n.csv"
original_class_data_nolabels_n_downsampled="spect_heart_nolabels_n_downsampled.csv"
original_class_data_downsampled_n="spect_heart_downsampled_n.csv"
original_class_data_downsampled_sorted_n="spect_heart_downsampled_sorted_n.csv"
original_class_data_downsampled_sorted="spect_heart_downsampled_sorted.csv"
original_class_data_downsampled_sorted_uniq="spect_heart_downsampled_sorted_uniq.csv"
original_class_data_downsampled_sorted_dup="spect_heart_downsampled_sorted_dup.csv"
original_class_data_downsampled_sorted_uniq_real="spect_heart_downsampled_sorted_uniq_real.csv"
original_class_data_downsampled="spect_heart_downsampled.csv"
awk_sh="rm_dup.awk"

# separate the labels from the rest of the data.
cut -d"," -f 1 $original_class_data > $original_class_data_labels
cut -d"," -f 2-23 $original_class_data > $original_class_data_nolabels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_labels > $original_class_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_nolabels > $original_class_data_nolabels_n

# downsample the domains.
cut -d"," -f 1-16 $original_class_data_nolabels_n > $original_class_data_nolabels_n_downsampled

# rename the labels
sed -i 's/,0/,normal/g' $original_class_data_labels_n
sed -i 's/,1/,abnormal/g' $original_class_data_labels_n

# join back, sort, remove the first column, and uniq it
join -t, $original_class_data_nolabels_n_downsampled $original_class_data_labels_n -a 1 -o auto -e 'no match' > $original_class_data_downsampled_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 -k7,7 -k8,8 -k9,9 -k10,10 -k11,11 -k12,12 -k13,13 -k14,14 -k15,15 -k16,16 \
	$original_class_data_downsampled_n > $original_class_data_downsampled_sorted_n
cut -d"," -f 2- $original_class_data_downsampled_sorted_n > $original_class_data_downsampled_sorted
uniq $original_class_data_downsampled_sorted > $original_class_data_downsampled_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,normal/;normal/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,abnormal/;abnormal/g' $original_class_data_downsampled_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_data_downsampled_sorted_uniq > $original_class_data_downsampled_sorted_dup
grep -v -x -f $original_class_data_downsampled_sorted_dup $original_class_data_downsampled_sorted_uniq \
	> $original_class_data_downsampled_sorted_uniq_real

# change label back to "0" for normal and "1" for abnormal.
cp $original_class_data_downsampled_sorted_uniq_real $original_class_data_downsampled
sed -i 's/;normal/,0/g' $original_class_data_downsampled
sed -i 's/;abnormal/,1/g' $original_class_data_downsampled

# remove intermediate files
rm $original_class_data_labels
rm $original_class_data_nolabels
rm $original_class_data_labels_n
rm $original_class_data_nolabels_n
rm $original_class_data_nolabels_n_downsampled
rm $original_class_data_downsampled_n
rm $original_class_data_downsampled_sorted_n
rm $original_class_data_downsampled_sorted
rm $original_class_data_downsampled_sorted_uniq
rm $original_class_data_downsampled_sorted_dup
rm $original_class_data_downsampled_sorted_uniq_real
