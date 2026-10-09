# This script converts Supplementary Table 1 into a clean lane-design table
# and verifies that its 14 lanes match the RNA-seq count columns in
# Supplementary Table 2.

table1_file <- "data/gilad/SupplementaryTable1.txt"
count_file <- "data/publisher/SupplementaryTable2.txt"
output_file <- "data/processed/rna_lane_design.tsv"

extract_run <- function(start, end, lines) {
  block <- lines[start:end]
  run <- as.integer(sub(".*Run ([12]).*", "\\1", trimws(block[1])))

  lane_line <- block[-1][nzchar(trimws(block[-1]))][1]
  concentration_line <- block[grep("^Concentration \\(pM\\)", trimws(block))][1]

  lane_labels <- trimws(strsplit(lane_line, "\t", fixed = TRUE)[[1]])
  lane_labels <- lane_labels[nzchar(lane_labels)]

  concentration <- trimws(strsplit(concentration_line, "\t", fixed = TRUE)[[1]])
  concentration <- as.numeric(concentration[nzchar(concentration)][-1])

  lane_parts <- regmatches(
    lane_labels,
    regexec("^L([0-9]+) - (kidney|liver)$", lane_labels)
  )
  if (any(lengths(lane_parts) != 3) || length(lane_labels) != length(concentration)) {
    stop("Could not convert the Run ", run, " block in SupplementaryTable1.txt.")
  }

  lane_number <- vapply(lane_parts, function(x) x[2], character(1))
  tissue <- vapply(lane_parts, function(x) x[3], character(1))

  data.frame(
    lane = paste0("R", run, "L", lane_number, tools::toTitleCase(tissue)),
    tissue = tissue,
    run = run,
    concentration_pM = concentration,
    stringsAsFactors = FALSE
  )
}

table1_lines <- readLines(table1_file, warn = FALSE)
run_starts <- grep("Run [12]", table1_lines)
if (length(run_starts) != 2) {
  stop("Expected one Run 1 block and one Run 2 block in SupplementaryTable1.txt.")
}

lane_design <- rbind(
  extract_run(run_starts[1], run_starts[2] - 1, table1_lines),
  extract_run(run_starts[2], length(table1_lines), table1_lines)
)
if (nrow(lane_design) != 14) {
  stop("Expected 14 RNA-seq lanes; found ", nrow(lane_design), ".")
}

counts <- read.delim(
  count_file,
  header = TRUE,
  sep = "\t",
  check.names = FALSE,
  stringsAsFactors = FALSE
)
lane_columns <- grep("^R[12]L[0-9]+(Kidney|Liver)$", names(counts), value = TRUE)
if (!identical(lane_columns, lane_design$lane)) {
  stop("Lane names in SupplementaryTable2.txt do not match the converted lane design.")
}

count_matrix <- as.matrix(counts[, lane_columns, drop = FALSE])
storage.mode(count_matrix) <- "numeric"
if (any(!is.finite(count_matrix)) || any(count_matrix < 0) || any(count_matrix != floor(count_matrix))) {
  stop("SupplementaryTable2.txt contains invalid count values.")
}

dir.create(dirname(output_file), recursive = TRUE, showWarnings = FALSE)
write.table(lane_design, output_file, sep = "\t", quote = FALSE, row.names = FALSE)
