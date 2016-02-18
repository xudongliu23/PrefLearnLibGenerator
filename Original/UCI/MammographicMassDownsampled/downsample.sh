#!/bin/bash

original_class_data="mammographic_mass.csv"
original_class_data_labels="mammographic_mass_labels.csv"
original_class_data_nolabels="mammographic_mass_nolabels.csv"
original_class_data_labels_n="mammographic_mass_labels_n.csv"
original_class_data_nolabels_n="mammographic_mass_nolabels_n.csv"
original_class_data_downsampled_n="mammographic_mass_downsampled_n.csv"
original_class_data_downsampled_sorted_n="mammographic_mass_downsampled_sorted_n.csv"
original_class_data_downsampled_sorted="mammographic_mass_downsampled_sorted.csv"
original_class_data_downsampled_sorted_uniq="mammographic_mass_downsampled_sorted_uniq.csv"
original_class_data_downsampled_sorted_dup="mammographic_mass_downsampled_sorted_dup.csv"
original_class_data_downsampled_sorted_uniq_real="mammographic_mass_downsampled_sorted_uniq_real.csv"
original_class_data_downsampled="mammographic_mass_downsampled.csv"
awk_sh="rm_dup.awk"

# separate the labels from the rest of the data.
cut -d"," -f 6 $original_class_data > $original_class_data_labels
cut -d"," -f 1-5 $original_class_data > $original_class_data_nolabels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_labels > $original_class_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_nolabels > $original_class_data_nolabels_n

# downsample the domains.
# downsample the 2nd column (BI-RADS).
awk -F"," -vOFS="," '{ gsub(/^1$/, "low",     $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^2$/, "medium",  $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^3$/, "high",    $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^4$/, "vhigh",   $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^5$/, "vhigh",   $2) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 3rd column (Age).
awk -F"," -vOFS="," '{ gsub(/^10$/, "low",    $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^20$/, "low",    $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^30$/, "medium", $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^40$/, "medium", $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^50$/, "high",   $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^60$/, "high",   $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^70$/, "vhigh",  $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^80$/, "vhigh",  $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^90$/, "vhigh",  $3) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
# downsample the 5th column (Margin).
awk -F"," -vOFS="," '{ gsub(/^1$/, "low",     $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^2$/, "medium",  $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^3$/, "high",    $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^4$/, "vhigh",   $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n
awk -F"," -vOFS="," '{ gsub(/^5$/, "vhigh",   $5) }1' $original_class_data_nolabels_n > tmp && mv tmp $original_class_data_nolabels_n

# join back, sort, remove the first column, and uniq it
join -t, $original_class_data_nolabels_n $original_class_data_labels_n -a 1 -o auto -e 'no match' > $original_class_data_downsampled_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 \
	$original_class_data_downsampled_n > $original_class_data_downsampled_sorted_n
cut -d"," -f 2- $original_class_data_downsampled_sorted_n > $original_class_data_downsampled_sorted
uniq $original_class_data_downsampled_sorted > $original_class_data_downsampled_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,0$/;good/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,1$/;bad/g' $original_class_data_downsampled_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_data_downsampled_sorted_uniq > $original_class_data_downsampled_sorted_dup
grep -v -x -f $original_class_data_downsampled_sorted_dup $original_class_data_downsampled_sorted_uniq \
	> $original_class_data_downsampled_sorted_uniq_real

# change label back to "1" for good and "2" for bad.
cp $original_class_data_downsampled_sorted_uniq_real $original_class_data_downsampled
sed -i 's/;good$/,0/g' $original_class_data_downsampled
sed -i 's/;bad$/,1/g' $original_class_data_downsampled

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
