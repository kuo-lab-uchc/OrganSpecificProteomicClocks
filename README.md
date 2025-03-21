# OrganSpecificProteomicClocks

This R code (github_organ_specific_clocks.R) is not meant to be general, mainly for deriving organ-specific proteomic clocks developed by Goeminne et al. using the UK Biobank Olink explore 3720 proteomic data. 

It requires a proteomic dataset, here example_proteomic_data.txt, where the first column is participant ID, followed by individual proteins. Additionally, it needs two tables with coefficients associated with each proteins in first-generation and second generation clocks that you can download from this repository (first_generaltion_clocks_coef.csv and second_generaltion_clocks_coef.csv). 

At the end, it will produce various first-generation and second-generation conventional and organ-specific proteomic clocks (first_generation_organ_specific_proteomic_clocks.txt and second_generation_organ_specific_proteomic_clocks.txt). 

First-generation proteomic clocks were developed to best predict chronological age, while second-generation proteomic clocks were developed to best predict mortality. Conventional proteomic clocks were trained using all the available proteins. In contrast, organ-specific clocks were trained using proteins that are significantly more highly expressed in a given tissue compared to other tissues in the GTEx.

Reference

Goeminne LJE, Vladimirova A, Eames A, Tyshkovskiy A, Argentieri MA, Ying K, Moqri M, Gladyshev VN. Plasma protein-based organ-specific aging and mortality models unveil diseases as accelerated aging of organismal systems. Cell Metab. 2025 Jan 7;37(1):205-222.e6. doi: 10.1016/j.cmet.2024.10.005. Epub 2024 Nov 1. PMID: 39488213.
