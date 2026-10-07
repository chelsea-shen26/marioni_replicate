# Replication of Marioni et al. 2008

This repository reproduces the main count-level RNA-seq and microarray analyses from Marioni et al. (2008), *RNA-seq: An assessment of technical reproducibility and comparison with gene expression arrays*.

## Data sources

### Publisher supplementary material

**Files retained:** `data/publisher/SupplementaryTable2.txt`, `SupplementaryTable3.txt`, and `SupplementaryCombined.pdf`, obtained from the [article supplement](https://genome.cshlp.org/content/18/9/1509#d1601604e3026).

**Contents:** Table 2 contains gene-level RNA-seq counts for all 14 sequencing lanes. Table 3 contains matched RNA-seq and microarray summary results. The PDF contains supplementary figures, lane comparisons, and experimental context.

### GEO GSE11045

**Files retained:** `data/geo/GSM279060.CEL.gz`–`GSM279065.CEL.gz`, obtained from [GEO GSE11045](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE11045).

**Contents:** Six raw Affymetrix CEL files: three kidney samples and three liver samples. They allow independent microarray preprocessing, normalisation, and differential-expression analysis.

### Gilad Lab public Box archive

**Files retained:** `data/gilad/AffyOut.txt`, `SupplementaryTable1.txt`, and `lane_designations.xls`, obtained from the [public archive](https://uchicago.app.box.com/s/agtdriffs54q7woo9eh5ojnp1945gtwt).

**Contents:** The two lane-metadata files identify tissue, run, RNA concentration, and lane structure. `AffyOut.txt` is the authors' processed microarray output and is retained for cross-checking.

## Results to replicate

### Figure 2: technical reproducibility across sequencing lanes

**What it shows:** Lane-to-lane variation is largely consistent with random sampling when the same sample is sequenced at the same concentration. Different concentrations produce more variation.

**Data needed:** The 14 lane-level RNA-seq count columns in `SupplementaryTable2.txt`, plus `SupplementaryTable1.txt` and `lane_designations.xls`.

### Figure 3: RNA-seq expression compared with microarrays

**What it shows:** RNA-seq read counts and microarray expression intensities are positively correlated in kidney and liver.

**Data needed:** `SupplementaryTable2.txt`, the six GEO CEL files, and shared gene identifiers. `SupplementaryTable3.txt` and `AffyOut.txt` are used for cross-checking.

### Figure 4: liver-versus-kidney fold changes across platforms

**What it shows:** RNA-seq and microarrays broadly agree on the direction and magnitude of liver-versus-kidney expression changes.

**Data needed:** RNA-seq counts, processed microarray expression values, shared gene identifiers, normalisation, and differential-expression testing.

### Figure 5: overlap of differentially expressed genes

**What it shows:** RNA-seq and microarrays identify substantially overlapping sets of genes that differ between liver and kidney.

**Data needed:** Differential-expression results from both platforms, multiple-testing correction, and shared gene identifiers.

### Table 1: sequencing depth and differential-expression detection

**What it shows:** More sequencing lanes increase the number of detected differentially expressed genes, but the gain decreases as additional lanes are added.

**Data needed:** The five 3 pM kidney lanes and five 3 pM liver lanes in `SupplementaryTable2.txt`, lane metadata, the differential-expression procedure, and microarray results.

## Repository structure

```text
data/       Source data retained for the replication
scripts/    Analysis scripts
results/    Numerical outputs
figures/    Recreated figures
```
