% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LDmatrix.R
\name{LDmatrix}
\alias{LDmatrix}
\title{Generates a data frame of pairwise linkage disequilibrium
statistics.}
\usage{
LDmatrix(
  snps,
  pop = "CEU",
  r2d = "r2",
  token = NULL,
  file = FALSE,
  genome_build = "grch37",
  api_root = "https://ldlink.nih.gov/LDlinkRest"
)
}
\arguments{
\item{snps}{list of between 2 - 1,000 variants, using an rsID or chromosome coordinate (e.g. "chr7:24966446")}

\item{pop}{a 1000 Genomes Project population, (e.g. YRI or CEU), multiple allowed, default = "CEU"}

\item{r2d}{r2d, either "r2" for LD R2 or "d" for LD D', default = "r2"}

\item{token}{LDlink provided user token, default = NULL, register for token at \url{https://ldlink.nih.gov/?tab=apiaccess}}

\item{file}{Optional character string naming a path and file for saving results.  If file = FALSE, no file will be generated, default = FALSE.}

\item{genome_build}{Choose between one of the three options...`grch37` for genome build GRCh37 (hg19),
`grch38` for GRCh38 (hg38), or `grch38_high_coverage` for GRCh38 High Coverage (hg38) 1000 Genome Project
data sets.  Default is GRCh37 (hg19).}

\item{api_root}{Optional alternative root url for API.}
}
\value{
a data frame
}
\description{
Generates a data frame of pairwise linkage disequilibrium
statistics.
}
\examples{
\dontrun{LDmatrix(c("rs3", "rs4", "rs148890987"),
                  "YRI", "r2",
                  token = Sys.getenv("LDLINK_TOKEN"))
                 }

}
