#!/bin/bash

original_class_data="discrete_credit_approval.csv"
original_class_data_labels="discrete_credit_approval_labels.csv"
original_class_data_nolabels="discrete_credit_approval_nolabels.csv"
original_class_data_labels_n="discrete_credit_approval_labels_n.csv"
original_class_data_nolabels_n="discrete_credit_approval_nolabels_n.csv"
original_class_data_downsampled_further_n="discrete_credit_approval_downsampled_further_n.csv"
original_class_data_downsampled_further_sorted_n="discrete_credit_approval_downsampled_further_sorted_n.csv"
original_class_data_downsampled_further_sorted="discrete_credit_approval_downsampled_further_sorted.csv"
original_class_data_downsampled_further_sorted_uniq="discrete_credit_approval_downsampled_further_sorted_uniq.csv"
original_class_data_downsampled_further_sorted_dup="discrete_credit_approval_downsampled_further_sorted_dup.csv"
original_class_data_downsampled_further_sorted_uniq_real="discrete_credit_approval_downsampled_further_sorted_uniq_real.csv"
original_class_data_downsampled_further="discrete_credit_approval_downsampled_further.csv"
awk_sh="rm_dup.awk"

# separate the labels from the rest of the data.
cut -d"," -f 16 $original_class_data > $original_class_data_labels
cut -d"," -f 1-10 $original_class_data > $original_class_data_nolabels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_labels > $original_class_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_nolabels > $original_class_data_nolabels_n

# downsample the domains.
# downsample the 7th column (A6).
awk -F"," -vOFS="," '{ gsub(/^[c|d|i]$/, "low", $7) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^cc$/, "low", $7) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^[j|k|m|r]$/, "medium", $7) }1' $original_class_data_nolabels_n \
	> tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^[q|w|x|e]$/, "high", $7) }1' $original_class_data_nolabels_n \
	> tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^aa$/, "vhigh", $7) }1' $original_class_data_nolabels_n \
	> tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^ff$/, "vhigh", $7) }1' $original_class_data_nolabels_n \
	> tmp && mv tmp $original_class_data_nolabels_n
# downsample the 8th column (A7).
awk -F"," -vOFS="," '{ gsub(/^[v|h]$/, "low", $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^bb$/, "medium", $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^j$/, "medium", $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^[n|z]$/, "high", $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^dd$/, "vhigh", $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^ff$/, "vhigh", $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^[o]$/, "vhigh", $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n

# join back, sort, remove the first column, and uniq it
join -t, $original_class_data_nolabels_n $original_class_data_labels_n -a 1 -o auto -e 'no match' > $original_class_data_downsampled_further_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 -k7,7 -k8,8 -k9,9 -k10,10 -k11,11 \
	$original_class_data_downsampled_further_n > $original_class_data_downsampled_further_sorted_n
cut -d"," -f 2- $original_class_data_downsampled_further_sorted_n > $original_class_data_downsampled_further_sorted
uniq $original_class_data_downsampled_further_sorted > $original_class_data_downsampled_further_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,+$/;+/g' $original_class_data_downsampled_further_sorted_uniq
sed -i 's/,-$/;-/g' $original_class_data_downsampled_further_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_data_downsampled_further_sorted_uniq > $original_class_data_downsampled_further_sorted_dup
grep -v -x -f $original_class_data_downsampled_further_sorted_dup $original_class_data_downsampled_further_sorted_uniq \
	> $original_class_data_downsampled_further_sorted_uniq_real

# change label back to "+" for positive and "-" for negative.
cp $original_class_data_downsampled_further_sorted_uniq_real $original_class_data_downsampled_further
sed -i 's/;+$/,+/g' $original_class_data_downsampled_further
sed -i 's/;-$/,-/g' $original_class_data_downsampled_further

# remove intermediate files
rm $original_class_data_labels
rm $original_class_data_nolabels
rm $original_class_data_labels_n
rm $original_class_data_nolabels_n
rm $original_class_data_downsampled_further_n
rm $original_class_data_downsampled_further_sorted_n
rm $original_class_data_downsampled_further_sorted
rm $original_class_data_downsampled_further_sorted_uniq
rm $original_class_data_downsampled_further_sorted_dup
rm $original_class_data_downsampled_further_sorted_uniq_real
