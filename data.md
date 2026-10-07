# Data Audit for Marioni et al. 2008 Replication

## 1. Data sources and contents

### Publisher supplementary material

**Files retained:** `data/publisher/SupplementaryTable2.txt`, `SupplementaryTable3.txt`, and `SupplementaryCombined.pdf`, obtained from the [article supplement](https://genome.cshlp.org/content/18/9/1509#d1601604e3026).

**Contents:** Table 2 is the authors' processed gene-level RNA-seq count table for all 14 lanes. Table 3 provides matched RNA-seq and microarray summaries. The PDF supplies supplementary figures, lane comparisons, and experimental context. These are the closest available records of the reported analyses.

### GEO: [GSE11045](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE11045)

**Files retained:** `data/geo/GSM279060.CEL.gz`–`GSM279065.CEL.gz`.

**Contents:** These are the six public raw Affymetrix CEL files. The analysis script will record which samples are kidney and liver, using the sample descriptions on the GEO record. They make it possible to rerun RMA normalisation and differential-expression testing rather than relying only on author-processed values.

### Gilad Lab public Box archive

**Files retained:** `data/gilad/AffyOut.txt`, `SupplementaryTable1.txt`, and `lane_designations.xls`, obtained from the [public archive](https://uchicago.app.box.com/s/agtdriffs54q7woo9eh5ojnp1945gtwt).

**Contents:** `SupplementaryTable1.txt` and `lane_designations.xls` identify the tissue, run, RNA concentration, and lane structure. `AffyOut.txt` is the authors' processed microarray output, retained as a direct cross-check for our GEO-based reconstruction.

## 2. Results to replicate

### Figure 2: technical reproducibility across sequencing lanes

**What it shows:** The QQ plots test whether lane-to-lane variation is consistent with random sampling. Lanes sequenced at the same RNA concentration show very little systematic deviation; lanes at different concentrations show more variation.

**Data needed:** The 14 lane-level RNA-seq count columns in `SupplementaryTable2.txt`, plus `SupplementaryTable1.txt` and `lane_designations.xls` to identify the tissue, concentration, run, and lane for each column.

### Figure 3: RNA-seq expression compared with microarrays

**What it shows:** RNA-seq read counts and microarray expression intensities are positively correlated in kidney and liver.

**Data needed:** RNA-seq counts from `SupplementaryTable2.txt`; the six GEO CEL files for microarray preprocessing; and shared gene identifiers. `SupplementaryTable3.txt` and `AffyOut.txt` provide author-processed values for cross-checking.

### Figure 4: liver-versus-kidney fold changes across platforms

**What it shows:** RNA-seq and microarrays broadly agree on the direction and magnitude of liver-versus-kidney expression changes, especially for genes with more RNA-seq reads.

**Data needed:** The Figure 3 inputs, plus normalisation, differential-expression testing, and a common set of genes across the two platforms. `SupplementaryTable3.txt` provides the authors' matched summary values for cross-checking.

### Figure 5: overlap of differentially expressed genes

**What it shows:** RNA-seq and microarrays identify substantially overlapping sets of genes that differ between liver and kidney, while RNA-seq identifies additional genes.

**Data needed:** RNA-seq and microarray differential-expression results from the Figure 4 analysis, a multiple-testing correction, and shared gene identifiers.

### Table 1: sequencing depth and differential-expression detection

**What it shows:** Using more sequencing lanes increases the number of detected differentially expressed genes, but the gain becomes smaller as more lanes are added.

**Data needed:** The five 3 pM kidney lanes and five 3 pM liver lanes in `SupplementaryTable2.txt`; lane metadata to select them; the differential-expression procedure; and the microarray results for the cross-platform overlap and fold-change correlation.
