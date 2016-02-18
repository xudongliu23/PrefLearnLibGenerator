#!/bin/bash

original_class_data="discrete_vehicle.csv"
original_class_data_labels="discrete_vehicle_labels.csv"
original_class_data_nolabels="discrete_vehicle_nolabels.csv"
original_class_data_labels_n="discrete_vehicle_labels_n.csv"
original_class_data_nolabels_n="discrete_vehicle_nolabels_n.csv"
original_class_data_downsampled_n="discrete_vehicle_downsampled_n.csv"
original_class_data_downsampled_sorted_n="discrete_vehicle_downsampled_sorted_n.csv"
original_class_data_downsampled_sorted="discrete_vehicle_downsampled_sorted.csv"
original_class_data_downsampled_sorted_uniq="discrete_vehicle_downsampled_sorted_uniq.csv"
original_class_data_downsampled_sorted_dup="discrete_vehicle_downsampled_sorted_dup.csv"
original_class_data_downsampled_sorted_uniq_real="discrete_vehicle_downsampled_sorted_uniq_real.csv"
original_class_data_downsampled="discrete_vehicle_downsampled.csv"
awk_sh="rm_dup.awk"

# separate the labels from the rest of the data.
cut -d"," -f 19 $original_class_data > $original_class_data_labels
cut -d"," -f 1-15 $original_class_data > $original_class_data_nolabels

# add line numbers.
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_labels > $original_class_data_labels_n
awk '{printf("%d,%s\n", NR,$0)}' $original_class_data_nolabels > $original_class_data_nolabels_n

# no need to further downsample the domains.

# join back, sort, remove the first column, and uniq it
join -t, $original_class_data_nolabels_n $original_class_data_labels_n -a 1 -o auto -e 'no match' > $original_class_data_downsampled_n
sort -t',' -k2,2 -k3,3 -k4,4 -k5,5 -k6,6 -k7,7 -k8,8 -k9,9 -k10,10 -k11,11 -k12,12 -k13,13 -k14,14 -k15,15 -k16,16 \
	$original_class_data_downsampled_n > $original_class_data_downsampled_sorted_n
cut -d"," -f 2- $original_class_data_downsampled_sorted_n > $original_class_data_downsampled_sorted
uniq $original_class_data_downsampled_sorted > $original_class_data_downsampled_sorted_uniq

# change the separator for label (last column) from "," to ";"
sed -i 's/,bus/;bus/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,opel/;opel/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,saab/;saab/g' $original_class_data_downsampled_sorted_uniq
sed -i 's/,van/;van/g' $original_class_data_downsampled_sorted_uniq

# call awk script to compute duplicate lines, and remove them.
awk -f $awk_sh $original_class_data_downsampled_sorted_uniq > $original_class_data_downsampled_sorted_dup
grep -v -x -f $original_class_data_downsampled_sorted_dup $original_class_data_downsampled_sorted_uniq \
	> $original_class_data_downsampled_sorted_uniq_real

# change label back to "1" for good and "2" for bad.
cp $original_class_data_downsampled_sorted_uniq_real $original_class_data_downsampled
sed -i 's/;bus/,bus/g' $original_class_data_downsampled
sed -i 's/;opel/,opel/g' $original_class_data_downsampled
sed -i 's/;saab/,saab/g' $original_class_data_downsampled
sed -i 's/;van/,van/g' $original_class_data_downsampled

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
