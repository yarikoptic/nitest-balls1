#!/bin/bash
#emacs: -*- mode: shell-script; c-basic-offset: 4; tab-width: 4; indent-tabs-mode: t -*- 
#ex: set sts=4 ts=4 sw=4 noet:
#-------------------------- =+- Shell script -+= --------------------------
#
# @file      sort_files.sh
# @date      Tue Aug  5 17:49:34 2014
# @brief
#
#
#  Yaroslav Halchenko                                            Dartmouth
#  web:     http://www.onerussian.com                              College
#  e-mail:  yoh@onerussian.com                              ICQ#: 60653192
#
# DESCRIPTION (NOTES):
#
# COPYRIGHT: Yaroslav Halchenko 2014
#
# LICENSE: MIT
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
#
#-----------------\____________________________________/------------------

codenames=( NA NA NA NA NA NA
            T1 # 6
            T2 # 7
			T2-interleaved # 8
            T2_ # 9
            T2_-interleaved # 10
            fieldmap # 11
			DTI # 12
)

#echo ${codenames[6]}
#echo ${codenames[*]}
CMD=
#echo

# Let's process DICOMs and move using their SeriesDescription
IN=_2sort_
cp -rl _incoming_ $IN
for f in $IN/DICOM/*.dcm; do
	desc=$(dcmdump $f| sed -ne '/SeriesDescription$/s,.*\[\(.*\)\].*,\1,gp' | sed -e 's,\*,_,g')
	if echo ${codenames[*]} | grep -q " $desc"; then
		$CMD mv $f DICOM/$desc.dcm;
	fi
done

# For NIFTIs use their order index as in codenames
for f in $IN/NIFTI/*_1.nii.gz; do
	idx=$(echo $f | sed -e 's,.*_\([0-9]*\)_1\.nii\.gz,\1,g')
	desc=${codenames[$idx]}
	$CMD mv $f NIFTI/$desc.nii.gz
done

# Similar for PAR/REC
for f in $IN/PARREC/*-*.*; do
	idx=$(echo $f | sed -e 's,.*_0*\([0-9]*\)_1-.*.\(PAR\|REC\),\1,g')
	desc=${codenames[$idx]}
	$CMD mv $f PARREC/$desc.${f##*.}
done

echo "Left out files"
tree _2sort_
rm -rf _2sort_
