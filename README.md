nitest-balls1
=============

Is a collection of imaging data collected on Philips Intera Achieva 3T MR scanner at Dartmouth Brain Imaging Center.

Version
-------

1.0

Files
-----

Repository contains following directories

- DICOM, NIFTI, PARREC -- directories with data files for each exported format, where files are named after specific modality/protocol: T1, T2, T2_ (for T2*, i.e. BOLD), fieldmap, and DTI.
    For T2 and T2_ two acquisitions were done: with default slices order (no additional suffix), and with -interleaved suffix for Philips interleaved order.
- cards -- exam cards for the protocols ran exported from the scanner console
- protocols -- text files describing acquisition details per each protocol, as exported from the scanner console.


License
-------

This dataset is made available under the Public Domain Dedication and License v1.0 whose full text can be found at: http://www.opendatacommons.org/licenses/pddl/1.0/