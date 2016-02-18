#!/bin/bash

original_class_data="breast_cancer_wisconsin.csv"
original_class_data_labels="breast_cancer_wisconsin_labels.csv"
original_class_data_nolabels="breast_cancer_wisconsin_nolabels.csv"
original_class_data_labels_n="breast_cancer_wisconsin_labels_n.csv"
original_class_data_nolabels_n="breast_cancer_wisconsin_nolabels_n.csv"
original_class_data_downsampled_n="breast_cancer_wisconsin_downsampled_n.csv"
original_class_data_downsampled_sorted_n="breast_cancer_wisconsin_downsampled_sorted_n.csv"
original_class_data_downsampled_sorted="breast_cancer_wisconsin_downsampled_sorted.csv"
original_class_data_downsampled_sorted_uniq="breast_cancer_wisconsin_downsampled_sorted_uniq.csv"
original_class_data_downsampled_sorted_dup="breast_cancer_wisconsin_downsampled_sorted_dup.csv"
original_class_data_downsampled_sorted_uniq_real="breast_cancer_wisconsin_downsampled_sorted_uniq_real.csv"
original_class_data_downsampled="breast_cancer_wisconsin_downsampled.csv"
awk_sh="rm_dup.awk"

# separate the labels from the rest of the data.
cut -d"," -f 10 $original_class_data > $original_class_data_labels
cut -d"," -f 1-9 $original_class_data > $original_class_data_nolabels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_labels > $original_class_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_nolabels > $original_class_data_nolabels_n

# downsample the domains.
sed -i 's/,10/,vhigh/g' $original_class_data_nolabels_n
sed -i 's/,9/,high/g' $original_class_data_nolabels_n
sed -i 's/,8/,high/g' $original_class_data_nolabels_n
sed -i 's/,7/,high/g' $original_class_data_nolabels_n
sed -i 's/,6/,medium/g' $original_class_data_nolabels_n
sed -i 's/,5/,medium/g' $original_class_data_nolabels_n
sed -i 's/,4/,medium/g' $original_class_data_nolabels_n
sed -i 's/,3/,low/g' $original_class_data_nolabels_n
sed -i 's/,2/,low/g' $original_class_data_nolabels_n
sed -i 's/,1/,low/g' $original_class_data_nolabels_n

# rename the labels
sed -i 's/,2$/,good/g' $original_class_data_labels_n
sed -i 's/,4$/,bad/g' $original_class_data_labels_n

# join back, sort, remove the first column, and uniq it
join -t, $original_class_data_nolabels_n $original_class_data_labels_n -a 1 -o auto -e 'no match' > $original_class_data_downsampled_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 -k7,7 -k8,8 -k9,9 -k10,10 $original_class_data_downsampled_n \
	> $original_class_data_downsampled_sorted_n
cut -d"," -f 2- $original_class_data_downsampled_sorted_n > $original_class_data_downsampled_sorted
uniq $original_class_data_downsampled_sorted > $original_class_data_downsampled_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,good$/;good/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,bad$/;bad/g' $original_class_data_downsampled_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_data_downsampled_sorted_uniq > $original_class_data_downsampled_sorted_dup
grep -v -x -f $original_class_data_downsampled_sorted_dup $original_class_data_downsampled_sorted_uniq \
	> $original_class_data_downsampled_sorted_uniq_real

# change label back to "2" for good and "4" for malignant.
cp $original_class_data_downsampled_sorted_uniq_real $original_class_data_downsampled
sed -i 's/;good$/,2/g' $original_class_data_downsampled
sed -i 's/;bad$/,4/g' $original_class_data_downsampled

# remove intermediate files
rm $original_class_data_labels
rm $original_class_data_nolabels
rm $original_class_data_labels_n
rm $original_class_data_nolabels_n
rm $original_class_data_downsampled_n
rm $original_class_data_downsampled_sorted_n
rm $original_class_data_downsampled_sorted
rm $original_class_data_downsampled_sorted_uniq
rm $original_class_data_downsampled_sorted_dup
rm $original_class_data_downsampled_sorted_uniq_real
