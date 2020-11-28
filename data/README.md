---
title: "Data"
author: "June Grimes"
date: "11/28/2020"
output: html_document
---

# Data Overview

This Folder contains all relevant data for my morphovariation project. Notably the [raw TPS coordinates](https://github.com/Juniper41/mandibular_morphovariation/tree/main/data/Raw%20TPSdig%20Coordinates) collected through TPSdig, the TPS data with [omitted landmarks](https://github.com/Juniper41/mandibular_morphovariation/tree/main/data/data%20w:%20omissions) and those with their missing data points [estimated](https://github.com/Juniper41/mandibular_morphovariation/tree/main/data/estimated%20landmarks)

## Data Collection 
All manbiles are landmarked in TPSutil & TPSdig. Homologous features are landmarked and assigned an XY coordinate. Missing homologous features are given a missing landmark monicker in the form of "NA NA". 

## Data Omissions
Mandibles with at least 50% of each landmarked homologous feature where kept as/is. Mandibles with landmarked homologous features missing the majority of their data points however were exlcluded. This is to ensure that estimated landmarks were not being estimated at a rate that would drastically influence the Centroid Size of the rest of the mandible and thus create a "pinnochio effect". 

## Estimate Missing Landmarks
Species' Mandibles with missing landmarks were estimated using "estimate.missing" function in the geomorph package. Mandibles were then superimposed re-sized and oriented to reduce noise between mandibles using a procrustes analysis. 