#!/bin/bash

original_class_data="mushroom.csv"
original_class_data_labels="mushroom_labels.csv"
original_class_data_nolabels="mushroom_nolabels.csv"
original_class_data_labels_n="mushroom_labels_n.csv"
original_class_data_nolabels_n="mushroom_nolabels_n.csv"
original_class_data_downsampled_n="mushroom_downsampled_n.csv"
original_class_data_downsampled_sorted_n="mushroom_downsampled_sorted_n.csv"
original_class_data_downsampled_sorted="mushroom_downsampled_sorted.csv"
original_class_data_downsampled_sorted_uniq="mushroom_downsampled_sorted_uniq.csv"
original_class_data_downsampled_sorted_dup="mushroom_downsampled_sorted_dup.csv"
original_class_data_downsampled_sorted_uniq_real="mushroom_downsampled_sorted_uniq_real.csv"
original_class_data_downsampled="mushroom_downsampled.csv"
awk_sh="rm_dup.awk"

# separate the labels from the rest of the data.
cut -d"," -f 23 $original_class_data > $original_class_data_labels
cut -d"," -f 1-10 $original_class_data > $original_class_data_nolabels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_labels > $original_class_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_nolabels > $original_class_data_nolabels_n

# downsample the domains.
# downsample the 2nd column (CapShape).
awk -F"," -vOFS="," '{ gsub(/^b$/, "low",     $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^c$/, "low",     $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^x$/, "medium",  $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^f$/, "medium",  $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^k$/, "high",    $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^s$/, "vhigh",   $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 4th column (CapColor).
awk -F"," -vOFS="," '{ gsub(/^n$/, "low",    $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^b$/, "low",    $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^c$/, "low",    $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^g$/, "medium", $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^r$/, "medium", $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^p$/, "medium", $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^u$/, "high",   $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^e$/, "high",   $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^w$/, "high",   $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^y$/, "vhigh",  $4) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 6th column (Odor).
awk -F"," -vOFS="," '{ gsub(/^a$/, "low",    $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^l$/, "low",    $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^c$/, "low",    $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^y$/, "medium", $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^f$/, "medium", $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^m$/, "high",   $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^n$/, "high",   $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^p$/, "vhigh",  $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^s$/, "vhigh",  $6) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 10th column (GillColor).
awk -F"," -vOFS="," '{ gsub(/^k$/, "low",    $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^n$/, "low",    $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^b$/, "low",    $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^h$/, "medium", $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^g$/, "medium", $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^r$/, "medium", $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^o$/, "high",   $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^p$/, "high",   $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^u$/, "high",   $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^e$/, "vhigh",  $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^w$/, "vhigh",  $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^y$/, "vhigh",  $10) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n

# join back, sort, remove the first column, and uniq it
join -t, $original_class_data_nolabels_n $original_class_data_labels_n -a 1 -o auto -e 'no match' > $original_class_data_downsampled_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 -k7,7 -k8,8 -k9,9 -k10,10 -k11,11\
	$original_class_data_downsampled_n > $original_class_data_downsampled_sorted_n
cut -d"," -f 2- $original_class_data_downsampled_sorted_n > $original_class_data_downsampled_sorted
uniq $original_class_data_downsampled_sorted > $original_class_data_downsampled_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,e$/;good/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,p$/;bad/g' $original_class_data_downsampled_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_data_downsampled_sorted_uniq > $original_class_data_downsampled_sorted_dup
grep -v -x -f $original_class_data_downsampled_sorted_dup $original_class_data_downsampled_sorted_uniq \
	> $original_class_data_downsampled_sorted_uniq_real

# change label back to "1" for good and "2" for bad.
cp $original_class_data_downsampled_sorted_uniq_real $original_class_data_downsampled
sed -i 's/;good$/,e/g' $original_class_data_downsampled
sed -i 's/;bad$/,p/g' $original_class_data_downsampled

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
