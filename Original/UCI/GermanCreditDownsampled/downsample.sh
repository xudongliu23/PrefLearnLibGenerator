#!/bin/bash

original_class_data="discrete_german_credit.csv"
original_class_data_labels="discrete_german_credit_labels.csv"
original_class_data_nolabels="discrete_german_credit_nolabels.csv"
original_class_data_labels_n="discrete_german_credit_labels_n.csv"
original_class_data_nolabels_n="discrete_german_credit_nolabels_n.csv"
original_class_data_downsampled_n="discrete_german_credit_downsampled_n.csv"
original_class_data_downsampled_sorted_n="discrete_german_credit_downsampled_sorted_n.csv"
original_class_data_downsampled_sorted="discrete_german_credit_downsampled_sorted.csv"
original_class_data_downsampled_sorted_uniq="discrete_german_credit_downsampled_sorted_uniq.csv"
original_class_data_downsampled_sorted_dup="discrete_german_credit_downsampled_sorted_dup.csv"
original_class_data_downsampled_sorted_uniq_real="discrete_german_credit_downsampled_sorted_uniq_real.csv"
original_class_data_downsampled="discrete_german_credit_downsampled.csv"
awk_sh="rm_dup.awk"

# separate the labels from the rest of the data.
cut -d"," -f 21 $original_class_data > $original_class_data_labels
cut -d"," -f 1-15 $original_class_data > $original_class_data_nolabels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_labels > $original_class_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_nolabels > $original_class_data_nolabels_n

# downsample the domains.
# downsample the 4th column (A3).
awk -F"," -vOFS="," '{ gsub(/^a30$/, "low",    $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a31$/, "medium", $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a32$/, "high",   $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a33$/, "vhigh",  $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a34$/, "vhigh",  $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 5th column (A4).
awk -F"," -vOFS="," '{ gsub(/^a40$/, "low",    $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a41$/, "low",    $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a42$/, "low",    $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a43$/, "medium", $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a44$/, "medium", $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a45$/, "medium", $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a46$/, "high",   $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a47$/, "high",   $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a48$/, "high",   $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a49$/, "vhigh",  $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a410$/, "vhigh", $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 7th column (A6).
awk -F"," -vOFS="," '{ gsub(/^a61$/, "low",    $7) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a62$/, "medium", $7) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a63$/, "high",   $7) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a64$/, "vhigh",  $7) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a65$/, "vhigh",  $7) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 8th column (A7).
awk -F"," -vOFS="," '{ gsub(/^a71$/, "low",    $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a72$/, "medium", $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a73$/, "high",   $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a74$/, "vhigh",  $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a75$/, "vhigh",  $8) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 10th column (A9).
awk -F"," -vOFS="," '{ gsub(/^a91$/, "low",    $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a92$/, "medium", $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a93$/, "high",   $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a94$/, "vhigh",  $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^a95$/, "vhigh",  $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n

# join back, sort, remove the first column, and uniq it
join -t, $original_class_data_nolabels_n $original_class_data_labels_n -a 1 -o auto -e 'no match' > $original_class_data_downsampled_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 -k7,7 -k8,8 -k9,9 -k10,10 -k11,11 -k12,12 -k13,13 -k14,14 -k15,15 -k16,16 \
	$original_class_data_downsampled_n > $original_class_data_downsampled_sorted_n
cut -d"," -f 2- $original_class_data_downsampled_sorted_n > $original_class_data_downsampled_sorted
uniq $original_class_data_downsampled_sorted > $original_class_data_downsampled_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,1/;good/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,2/;bad/g' $original_class_data_downsampled_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_data_downsampled_sorted_uniq > $original_class_data_downsampled_sorted_dup
grep -v -x -f $original_class_data_downsampled_sorted_dup $original_class_data_downsampled_sorted_uniq \
	> $original_class_data_downsampled_sorted_uniq_real

# change label back to "1" for good and "2" for bad.
cp $original_class_data_downsampled_sorted_uniq_real $original_class_data_downsampled
sed -i 's/;good/,1/g' $original_class_data_downsampled
sed -i 's/;bad/,2/g' $original_class_data_downsampled

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
