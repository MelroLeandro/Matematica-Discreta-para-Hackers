---
layout: post
title:  "Circular Statisticsn"
subtitle: "The math for the statistical microscope"
author:  Mellean
tags:   libraries
category: free-energy
visualworkflow: false
---

# Circular Statistics

Circular statistics is a subfield of statistics, which is devoted to the development of statistical techniques for the use with data on an angular scale. On this scale, there is no designated zero and, in contrast to a linear scale, the designation of high and low values is arbitrary.

The circular nature of dihedral angles prevents the use of commonly used statistical techniques, as these would provide wrong or misleading results. The authors thus used tools from circular statistics to compute the average heading direction, assert the prevalence of a common heading direction for a group of birds and compare the average heading directions of an experimentally manipulated and a control group. The development of techniques suitable to this end started in the early 1950es by Fisher.

Here  we used the CircStat toolbox for analysis of dihedral data.

# CircStat for Matlab

Toolbox for circular statistics with Matlab.

Authors: Philipp Berens & Marc J. Velasco
Email: berens@tuebingen.mpg.de

Contributors:
Tal Krasovsky

Reference:
P. Berens, CircStat: A Matlab Toolbox for Circular Statistics, Journal of Statistical Software, Volume 31, Issue 10, 2009 http://www.jstatsoft.org/v31/i10

Please cite this paper when the provided code is used. See licensing terms for details.

Contents:
1. circ_r 				Resultant vector length
1. circ_mean 			Mean direction of a sample of circular data
1. circ_axial			Mean direction for axial data
1. circ_median			Median direction of a sample of circular data
1. circ_std 			Dispersion around the mean direction (std, mardia)
1. circ_var 			Circular variance
1. circ_skewness		Circular skewness
1. circ_kurtosis		Circular kurtosis
1. circ_moment			Circular p-th moment
1. circ_dist			Distances around a circle
1. circ_dist2			Pairwise distances around a circle
1. circ_confmean 		Confidence intervals for mean direction
1. circ_stats			Summary statistics
1. circ_rtest			Rayleigh's test for nonuniformity
1. circ_otest			Hodges-Ajne test (omnibus test) for nonuniformity
1. circ_raotest		Rao's spacing test for nonuniformity
1. circ_vtest			V-Test for nonuniformity with known mean direction
1. circ_medtest		Test for median angle
1. circ_mtest			One-sample test for specified mean direction
1. circ_wwtest			Multi-sample test for equal means, one-factor ANOVA
1. circ_hktest 		Two-factor ANOVA
1. circ_ktest      	Test for equal concentration parameter
1. circ_symtest		Test for symmetry around median angle
1. circ_kuipertest	 	Test whether two distributions are identical (like KS test)


circ_corrcc			Circular-circular correlation coefficient
circ_corrcl			Circular-linear correlation coefficient

circ_kappa 			Compute concentration parameter of a vm distribution

circ_plot			Visualization for circular data
circ_clust    		Simple clustering for circular data
circ_samplecdf	 	Evaluate CDF of a sample of angles

rad2ang				Convert radian to angular values
ang2rad				Convert angular to radian values

All functions take arguments in radians (expect for ang2rad). For a detailed description of arguments and outputs consult the help text in the files.

Since 2010, most functions for descriptive statistics can be used in Matlab style matrix computations. As a last argument, add the dimension along which you want to average. This changes the behavior slightly from previous relaeses, in that input is not reshaped anymore into vector format. Per default, all computations are performed columnwise (along dimension 1). If you prefer to use the old functions, for now they are contained in the subdirectory 'old'.

References:
- E. Batschelet, Circular Statistics in Biology, Academic Press, 1981
- N.I. Fisher, Statistical analysis of circular data, Cambridge University Press, 1996
- S.R. Jammalamadaka et al., Topics in circular statistics, World Scientific, 2001
- J.H. Zar, Biostatistical Analysis, Prentice Hall, 1999


The implementation follows in most cases 'Biostatistical Analysis' and all referenced equations and tables are taken from this book, if not otherwise noted. In some cases, the other books were preferred for implementation was more straightforward for solutions presented there.

If you have suggestions, bugs or feature requests or want to contribute code, please email us.

Disclaimer:
All functions in this toolbox were implemented with care and tested on the examples presented in 'Biostatistical Analysis' were possible. Nevertheless, they may contain errors or bugs, which may affect the outcome of your analysis. We do not take responsibility for any harm coming from using this toolbox, neither if it is caused by errors in the software nor if it is caused by its improper application. Please email us any bugs you find.

By Philipp Berens and Marc J. Velasco, 2009
berens@tuebingen.mpg.de , velasco@ccs.fau.edu - www.kyb.mpg.de/~berens/circStat.html
Distributed under Open Source BSD License
