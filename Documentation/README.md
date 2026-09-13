# Predictive Modelling of Protein Release from Microspheres Using MATLAB

## Project Overview

This project investigates the in-vitro release behavior of lysozyme from microspheres using mathematical modelling and MATLAB-based data analysis.

Published experimental release data were digitized from a reported lysozyme-loaded microsphere study and analyzed using commonly used drug-release models.

The project focuses on understanding the release profile, comparing mathematical models, evaluating prediction accuracy, and generating release predictions.

---

## Objective

The main objectives of this project are:

1. Analyze the cumulative lysozyme release profile with time.
2. Fit different mathematical drug-release models.
3. Compare model performance using R² and RMSE.
4. Analyze the variation of release rate with time.
5. Generate release predictions using the best-fitting model.
6. Quantify prediction errors.
7. Develop a reproducible MATLAB-based workflow for protein-release analysis.

---

## Experimental Data

The dataset represents cumulative lysozyme release from a microsphere formulation without additional excipients.

The release profile shows an initial burst followed by slower sustained release and a late-stage plateau.

The data used in this project were digitized from the published release curve rather than obtained from the user's laboratory experiment.

The published study reported approximately 21.99% release at day 1 and approximately 42.97% cumulative release by day 70 for the formulation without excipients.

---

## Methodology

The analysis workflow consists of:

Experimental Release Data
        ↓
Data Digitization
        ↓
MATLAB Data Processing
        ↓
Drug Release Model Fitting
        ↓
R² and RMSE Evaluation
        ↓
Best Model Identification
        ↓
Release Prediction
        ↓
Prediction Error Analysis
        ↓
Visualization and Results

---

## Mathematical Models

### 1. Zero-Order Model

The zero-order model assumes a relatively constant release rate.

Q = k₀t + Q₀

where:

- Q = cumulative drug release
- k₀ = zero-order release constant
- t = time
- Q₀ = fitted intercept

---

### 2. First-Order Model

The first-order model relates the release rate to the amount of drug remaining.

Q = 100 − (100 − Q₀)e^(−k₁t)

where:

- k₁ = first-order release constant
- t = time
- Q₀ = fitted initial value

---

### 3. Higuchi Model

The Higuchi model relates drug release to the square root of time.

Q = kH√t + intercept

where:

- kH = Higuchi release constant
- t = time

The Higuchi model provided the strongest fit among the three directly compared models for the digitized dataset.

---

### 4. Korsmeyer–Peppas Model

The Korsmeyer–Peppas relationship was evaluated using:

Mt / M∞ = ktⁿ

The exponent n was obtained from the slope of the log-transformed relationship.

Because the experimental profile shows incomplete release and an initial burst, the Korsmeyer–Peppas parameter should be interpreted cautiously rather than being used alone to establish a definitive release mechanism.

---

## Model Performance

| Model | R² | RMSE (%) |
|------|------|------|
| Zero-order | 0.9175 | 2.1715 |
| First-order | 0.9382 | 1.8792 |
| Higuchi | 0.9822 | 1.0071 |

Among the compared models, the Higuchi model produced the highest R² and lowest RMSE for this dataset.

This indicates that the Higuchi relationship provides the closest mathematical representation of the observed release profile among the models evaluated.

It should not, by itself, be interpreted as proof of a purely diffusion-controlled mechanism.

---

## Release Behavior

The release profile can be visually described in three broad stages:

### Initial Burst

A relatively large amount of lysozyme is released during the early stage.

### Sustained Release

The release continues at a substantially slower rate over the following period.

### Plateau

The cumulative release approaches a relatively stable value at later time points.

The published study also reported slow and incomplete release for the formulation without excipients.

---

## Prediction

The Higuchi model was used to generate a smooth predicted release curve and estimate cumulative release at selected time points.

Predictions were generated for:

- 10 days
- 20 days
- 30 days
- 40 days
- 50 days
- 60 days
- 70 days

Prediction accuracy was additionally evaluated using:

- MAE
- RMSE
- MAPE

---

## Software

- MATLAB Online
- MATLAB scripting
- MATLAB data analysis and visualization
- Microsoft Excel for result tables
- WebPlotDigitizer for digitization of the published graph

---

## Project Files

```text
Protein_Release_Microsphere_Modelling/
│
├── 01_MATLAB_Code/
│   ├── protein_release_analysis.m
│   ├── release_rate_analysis.m
│   ├── model_performance_visualization.m
│   ├── release_behavior_analysis.m
│   ├── final_project_visualization.m
│   ├── create_project_dataset.m
│   └── prediction_error_analysis.m
│
├── 02_Data/
│   ├── protein_release_dataset.csv
│   └── protein_release_dataset.xlsx
│
├── 03_Figures/
│   ├── Final_Project_Visualization.png
│   ├── Experimental_vs_Higuchi_Prediction.png
│   ├── Lysozyme_Release_Rate.png
│   ├── Release_Behavior_Analysis.png
│   ├── R_squared_Comparison.png
│   ├── RMSE_Comparison.png
│   └── Higuchi_Prediction_Error.png
│
├── 04_Results/
│   ├── Drug_Release_Model_Comparison.xlsx
│   ├── Higuchi_Future_Predictions.xlsx
│   ├── Model_Performance.xlsx
│   ├── Lysozyme_Release_Rate.xlsx
│   ├── Final_Model_Summary.xlsx
│   ├── Higuchi_Prediction_Error.xlsx
│   └── Prediction_Error_Summary.xlsx
│
└── 05_Documentation/
    └── README.md