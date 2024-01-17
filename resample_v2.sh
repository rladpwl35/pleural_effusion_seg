#!/bin/bash

sub=$1

fslinfo /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}.nii > /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/info.txt
sed -i -n '4p' /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/info.txt
sed -i 's/dim3/ /g' /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/info.txt
sed -i 's/^[[:space:]]*//' /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/info.txt
dim=`cat /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/info.txt`

nii2mnc -double -unsigned /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}.nii /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}.mnc
nii2mnc -double -unsigned /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_effusion.nii /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_effusion.mnc
mnc2nii -double -unsigned /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_effusion.mnc /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_truth.nii
nii2mnc -double -unsigned /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_truth.nii /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_truth.mnc

mincresample -step 3.0 3.0 3.0 -xnelements 174 -ynelements 174 -znelements ${dim} -trilinear /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}.mnc /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_resample.mnc
mincresample -step 3.0 3.0 3.0 -xnelements 174 -ynelements 174 -znelements ${dim} -nearest /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_truth.mnc /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_resample_truth.mnc

mnc2nii -double -unsigned /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_resample.mnc /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_resample.nii
mnc2nii -double -unsigned /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_resample_truth.mnc /nasdata4/son/PEstudy_KYJ/Raw_Data/${sub}/${sub}_resample_truth.nii
