# LDlinkR <img src="man/figures/logo.png" align="right" height=140/>
### Calculating Linkage Disequilibrium in Human Populations of Interest
<br>

<!-- badges: start -->

[![CRAN
version](https://www.r-pkg.org/badges/version-ago/LDlinkR)](https://cran.r-project.org/package=LDlinkR)
[![metacran 
downloads](https://cranlogs.r-pkg.org/badges/grand-total/LDlinkR?color=blue)](https://cran.r-project.org/package=LDlinkR)
![CRAN/METACRAN](https://img.shields.io/cran/l/LDlinkR?color=yellow)
[![status](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Website ldlink.nih.gov](https://img.shields.io/website-up-down-brightgreen-red/http/ldlink.nih.gov.svg)](https://ldlink.nih.gov/?tab=home)
[![R-CMD-check](https://github.com/CBIIT/ldlinkr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CBIIT/ldlinkr/actions/workflows/R-CMD-check.yaml)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7996355.svg)](https://doi.org/10.5281/zenodo.7996355)

<!-- badges: end -->



## Description

[LDlink](https://ldlink.nih.gov) is an interactive and powerful suite of web-based tools for querying germline variants in human population groups of interest to generate interactive tables and plots.  All population genotype data originates from Phase 3 (Version 5) of the 1000 Genomes Project and variant RS (reference SNP) numbers are indexed based on [dbSNP](https://www.ncbi.nlm.nih.gov/snp/) build 155.

*LDlinkR* is an R package developed to query and download results **(internet access required)** generated by [LDlink](https://ldlink.nih.gov) web-based applications from the R console.  It facilitates researchers who are interested in performing batch queries.  *LDlinkR* accelerates genomic research by providing efficient and user-friendly functions to programmatically interrogate pairwise linkage disequilibrium from large lists of genetic variants.

Please see the online [LDlink documentation](https://ldlink.nih.gov/?tab=help#Understanding_Linkage_Disequilibrium) for more information about understanding linkage disequilibrium (LD) and additional details about how [LDlink](https://ldlink.nih.gov) calculates patterns of LD across a variety of ancestral human populations.

## Installation
- The release version of *LDlinkR* can be installed from [CRAN](https://cran.r-project.org/) with:
``` r
install.packages("LDlinkR")
```
- The development version of the *LDlinkR* package can be installed from the [GitHub repository](https://github.com/CBIIT/LDlinkR) by using the `remotes` package:
``` r 
install.packages("remotes")
remotes::install_github("CBIIT/LDlinkR")
```
*LDlinkR* depends on the following packages:

- *utils*, version 3.4.2 or later
- *httr*, version 1.4.0 or later

Following installation, attach the *LDlinkR* package with:
``` r
library(LDlinkR)
```

## Personal Access Token - **Required**

In order to access the [LDlink](https://ldlink.nih.gov) API via *LDlinkR*, we use a personal access token. This is a common convention followed by many APIs and emulates the more familiar HTTPS username/password or SSH keys.

You will need to:

- Make a one-time request for your personal access token from a web browser at <https://ldlink.nih.gov/?tab=apiaccess>.
- Once registered, your personal access token will be emailed to you. It is a string of 12 random letters and numbers. 
- Provide your token as an argument when using *LDlinkR*.  See example below:

``` r
LDhap(snps = c("rs3", "rs4", "rs148890987"), 
      pop = "YRI", 
      token = "YourTokenHere123",
      genome_build = "grch38")
```

<br>

## Available Functions
| Function| Description|
|:--------|:-----------|
|`LDexpress`|Determine if a list of genomic variants is associated with gene expression in tissues of interest.|
|`LDhap` |Calculates population specific haplotype frequencies of all haplotypes observed for a list of query variants.|
|`LDmatrix` |Generates a data frame of pairwise linkage disequilibrium statistics.|
|`LDpair`|Investigates potentially correlated alleles for a pair of variants.|
|`LDpop` |Investigates allele frequencies and linkage disequilibrium patterns across 1000 Genomes Project populations.|
|`LDproxy` |Explore proxy and putative functional variants for a single query variant.|
|`LDproxy_batch`|Query `LDproxy` using a list of query variants.|
|`LDtrait` | Search the [GWAS Catalog](https://www.ebi.ac.uk/gwas/docs/file-downloads) (data updated nightly) to determine if a list of variants (or variants in LD with those variants) have been previously associated with a trait or disease.
|`SNPchip` |Find commercial genotyping chip arrays for variants of interest.|
|`SNPclip` |Prune a list of variants by linkage disequilibrium.|

<br>

## Utilities
|Utility Function |Description|
|:--------|:-----------|
|`list_chips` |Provides a data frame listing the names and abbreviation codes for available commercial SNP Chip Arrays from Illumina and Affymetrix.|
|`list_pop` |Provides a data frame listing the available reference populations from the 1000 Genomes Project.|
|`list_gtex_tissues` |Provides a data frame listing the GTEx full names, `LDexpress` full names (without spaces) and acceptable abbreviation codes of the 54 non-diseased tissue sites collected for the [GTEx Portal](https://gtexportal.org/home/) and used as input for the `LDexpress` function.|

<br>

## Basic example

In this basic example, the `LDproxy` function is used to explore proxy and putative functional variants for a single query variant. Usage by other functions is similar.


```{r}
my_proxies <- LDproxy(snp = "rs456", 
                      pop = "YRI", 
                      r2d = "r2", 
                      token = "YourTokenHere123",
                      genome_build = "grch38"
                     )
```
This example uses a single reference SNP ID (rsID) for the query variant, a population of interest (YRI = Yoruba in Ibadan, Nigeria), "r2" for the desired output to be based on estimated R<sup>2</sup>, and genome build GRCH38 (hg38). The output is stored in the variable `my_proxies`.  **Note:** Replace "YourTokenHere123" with your personal access token. See section above, "Personal Access Token".

<br>

The output can be viewed by using the R Utils Package `head` function to return the first parts of the object `my_proxies`.

```{r}
head(my_proxies)
```

```
##    RS_Number         Coord Alleles    MAF Distance Dprime     R2 Correlated_Alleles
## 1 rs58333091 chr7:24922800   (G/C) 0.1963        0      1 1.0000            G=G,C=C
## 2 rs60614713 chr7:24922807   (T/C) 0.1963        7      1 1.0000            G=T,C=C
## 3 rs59826225 chr7:24925014   (G/T) 0.1963     2214      1 1.0000            G=G,C=T
## 4      rs123 chr7:24926827   (C/A) 0.1963     4027      1 1.0000            G=C,C=A
## 5 rs10341080 chr7:24920084   (C/T) 0.2056    -2716      1 0.9434            G=C,C=T
## 6 rs56794736 chr7:24919358   (C/T) 0.2056    -3442      1 0.9434            G=C,C=T
##   RegulomeDB Function
## 1          4     <NA>
## 2         2b     <NA>
## 3          4     <NA>
## 4         1f     <NA>
## 5         3a     <NA>
## 6          7     <NA>
```

<br>

## Another example

This example demonstrates the use of the `LDexpress` function to search if a genomic variant (or list of variants) is associated with gene expression in tissues of interest. Usage by other functions is similar.  

```{r}
my_output <- LDexpress(snps = "rs4",
                       pop = c("YRI", "CEU"),
                       tissue =  c("ADI_SUB", "ADI_VIS_OME"),
                       token = "YourTokenHere123"
                      )
```

For the function arguments, this example uses a single rsID for a query variant, multiple populations (e.g., YRI = Yoruba in Ibadan, Nigeria and CEU = Utah Residents from North and West Europe) and multiple tissue types using acceptable abbreviations for available tissues (e.g., ADI_SUB = Adipose - Subcutaneous and ADI_VIS_OME = Adipose - Visceral (Omentum)). The output is stored in the variable `my_output`.  **Note:** Replace "YourTokenHere123" with your personal access token. See section above, "Personal Access Token".

<br>

In order to view the output, use the R Utils Package `head` function to return the first parts of the object `my_output`.

```{r}
head(my_output)
```

```
##   Query      RS_ID       Position                R2                D'
## 1   rs4 rs10637519 chr13:32430479 0.174249321651574 0.965976331360947
## 2   rs4 rs10637519 chr13:32430479 0.174249321651574 0.965976331360947
## 3   rs4   rs473641 chr13:32431244 0.174249321651574 0.965976331360947
## 4   rs4   rs473641 chr13:32431244 0.174249321651574 0.965976331360947
## 5   rs4   rs671746 chr13:32431263 0.174249321651574 0.965976331360947
## 6   rs4   rs671746 chr13:32431263 0.174249321651574 0.965976331360947
##    Gene_Symbol        Gencode_ID                       Tissue
## 1 RP1-257C22.2 ENSG00000279314.1       Adipose - Subcutaneous
## 2 RP1-257C22.2 ENSG00000279314.1 Adipose - Visceral (Omentum)
## 3 RP1-257C22.2 ENSG00000279314.1       Adipose - Subcutaneous
## 4 RP1-257C22.2 ENSG00000279314.1 Adipose - Visceral (Omentum)
## 5 RP1-257C22.2 ENSG00000279314.1       Adipose - Subcutaneous
## 6 RP1-257C22.2 ENSG00000279314.1 Adipose - Visceral (Omentum)
##   Non_effect_Allele_Freq Effect_Allele_Freq Effect_Size     P_value
## 1                G=0.565          GTC=0.435    0.225642  2.2578e-07
## 2                G=0.565          GTC=0.435    0.207161  1.0227e-05
## 3                A=0.565            G=0.435    0.225642  2.2578e-07
## 4                A=0.565            G=0.435    0.207161  1.0227e-05
## 5                C=0.565            T=0.435    0.226558 1.93289e-07
## 6                C=0.565            T=0.435    0.207161  1.0227e-05
```
<br>

## Utility function example

The following example demonstrates the usage of the utility function `list_pop` which returns a listing of the available reference populations from the 1000 Genomes Project and their corresponding population code and super population code used by *LDlinkR* functions. Usage of the other utility functions is similar.

```{r}
list_pop()
```

```
##    pop_code super_pop_code                                  pop_name
## 1       ALL            ALL                           ALL POPULATIONS
## 2       AFR            AFR                                   AFRICAN
## 3       YRI            AFR                  Yoruba in Ibadan, Nigera
## 4       LWK            AFR                    Luhya in Webuye, Kenya
## 5       GWD            AFR                 Gambian in Western Gambia
## 6       MSL            AFR                     Mende in Sierra Leone
## 7       ESN            AFR                            Esan in Nigera
## 8       ASW            AFR   Americans of African Ancestry in SW USA
## 9       ACB            AFR           African Carribbeans in Barbados
## 10      AMR            AMR                         AD MIXED AMERICAN
## 11      MXL            AMR    Mexican Ancestry from Los Angeles, USA
## 12      PUR            AMR            Puerto Ricans from Puerto Rico
## 13      CLM            AMR        Colombians from Medellin, Colombia
## 14      PEL            AMR                 Peruvians from Lima, Peru
## 15      EAS            EAS                                EAST ASIAN
## 16      CHB            EAS              Han Chinese in Bejing, China
## 17      JPT            EAS                  Japanese in Tokyo, Japan
## 18      CHS            EAS                      Southern Han Chinese
## 19      CDX            EAS       Chinese Dai in Xishuangbanna, China
## 20      KHV            EAS         Kinh in Ho Chi Minh City, Vietnam
## 21      EUR            EUR                                  EUROPEAN
## 22      CEU            EUR Utah Residents from North and West Europe
## 23      TSI            EUR                         Toscani in Italia
## 24      FIN            EUR                        Finnish in Finland
## 25      GBR            EUR           British in England and Scotland
## 26      IBS            EUR               Iberian population in Spain
## 27      SAS            SAS                               SOUTH ASIAN
## 28      GIH            SAS  Gujarati Indian from Houston, Texas, USA
## 29      PJL            SAS             Punjabi from Lahore, Pakistan
## 30      BEB            SAS                   Bengali from Bangladesh
## 31      STU            SAS              Sri Lankan Tamil from the UK
## 32      ITU            SAS                 Indian Telugu from the UK
```

<br>

## Additional examples
More detailed examples demonstrating the usage of each function can be found in the package vignette.

```{r}
browseVignettes("LDlinkR")
```

## Contributors

Timothy A. Myers, Stephen J. Chanock and Mitchell J. Machiela

