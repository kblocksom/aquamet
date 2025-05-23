% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nrsaChannelHabitat.r
\name{nrsaChannelHabitat}
\alias{nrsaChannelHabitat}
\title{Calculate NRSA Channel Habitat Metrics}
\usage{
nrsaChannelHabitat(
  bChannelUnit = NULL,
  bDataInformation = data.frame(value = c("FA", "RA", "RI", "GL", "PO", "CA", "DR"),
    metsSuffix = c("fa", "ra", "ri", "gl", "pool", "ca", "dr"), name = c("FALLS",
    "RAPID", "RIFFLE", "GLIDE", "POOL", "CASCADE", "DRY"), isFast = c(TRUE, TRUE, TRUE,
    FALSE, FALSE, TRUE, NA), stringsAsFactors = FALSE),
  wChannelUnit = NULL,
  wDataInformation = data.frame(value = c("FA", "CA", "RA", "RI", "GL", "PB", "PP", "PD",
    "PL", "PT", "P", "DR"), metsSuffix = c("fa", "ca", "ra", "ri", "gl", "pb", "pp",
    "pd", "pl", "pt", "p", "dr"), name = c("FALLS", "CASCADE", "RAPID", "RIFFLE",
    "GLIDE", "POOL_B", "POOL_PLUNGE", "POOL_D", "POOL_LATERAL", "POOL_TRENCH", "POOL",
    "DRY"), isFast = c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
    FALSE, NA), isPool = c(FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE,
    TRUE, TRUE, FALSE), stringsAsFactors = FALSE),
  isUnitTest = FALSE,
  argSavePath = NULL
)
}
\arguments{
\item{bChannelUnit}{A data frame containing channel unit codes from 
boatable reaches, with the following columns:
\itemize{
\item SITE    integer or character specifying the site visit
\item VALUE   character values, expected to be as specified in the 
bChannelUnitCodeList argument column 'code'. Only values which occur 
in the code column will be included in the calculations.
}}

\item{bDataInformation}{A data frame specifying the boatable 
channel unit codes, meanings and class memberships.  The default value 
of this argument is for the EPA NARS processing.  It should 
have the following columns:
\itemize{
 \item value  character values for the channel units as they occur in the 
 VALUE column of bChannelUnit
 \item metsSuffix  character values which are used as the suffix for 
 resulting metric names, e.g., a value of 'falls' results in 'pct_falls' 
 as the resulting metric name.
 \item name    character values that are used soley to
 help the human reader organize things. This column is not used by the code.
 \item isFast logical values for each habitat code specifying whether it 
 is considered fast or not.  Used to calculate pct_fast and  
 pct_slow; if this column does not exist, neither of those metrics will be
 calculated. Codes for which this value is NA will not be considered as 
 either fast nor slow.
}}

\item{wChannelUnit}{A data frame containing channel unit codes from wadeable 
reaches, with the following columns:
\itemize{
                 \item SITE    integer or character specifying the site 
                                visit
                 \item VALUE   character values, expected to be as specified
                               in the wChannelUnitCodeList argument column 
                               'code'. Only values which occur in the code
                               column will be included in the calculations.
}}

\item{wDataInformation}{A data frame specifying the wadeable 
channel unit codes, meanings and class memberships.  The default 
value of this argument is for the EPA NARS processing for 2008-9.  
The updated version for 2013-14 would be identical to the values used
in \emph{bChannelUnitCodeList} above. The data frame input should  
have the following columns:
\itemize{
   \item value        character values for the channel units
                     as they occur in the VALUE column of
                     bChannelUnit
   \item metsSuffix  character values which are used as the
                     suffix for resulting metric names, e.g.
                     a value of 'falls' results in 'pct_falls'
                     as the resulting metric name.
   \item name    character values that are used soley to
                     help the human reader organize things.
                     This column is not used by the code.
   \item isFast      logical values for each habitat code
                     specifying whether it is considered fast
                     or not.  Used to calculate pct_fast and
                     pct_slow; if this column does not exist,
                     neither of those metrics will be 
                     calculated. Codes for which this value
                     is NA will not be considered as either
                     fast nor slow.
   \item isPool      logical values for each habitat code
                     specifying whether it is considered a
                     pool habitat or not.  Used to calculate
                     pct_pool; if this column does not exist,
                     this metric will not be calculated.
}}

\item{isUnitTest}{Logical argument to determine whether errors should be ignored.
Should only be used for running a unit test. Default value is FALSE.}

\item{argSavePath}{character string specifying the path to which data 
arguments are saved as csv files, or NULL if those files are not to be 
written.}
}
\value{
Either a data frame when metric calculation is successful 
or a character string containing an error message when metric 
calculation is not successful.  The data frame contains the following 
columns:
\itemize{
   \item SITE - universal ID value
   \item METRIC - metric name
   \item VALUE - metric value
}
 Metrics calculated include: pct_fa, pct_ca, pct_ra, pct_ri, pct_gl,  
 pct_fast, pct_slow, pct_pool, pct_pp, pct_pd, pct_pb, pct_pt, pct_pl,
 pct_p, pct_dr  
 
Descriptions for all NRSA metrics can be found at:
\href{https://github.com/USEPA/aquamet/blob/master/inst/NRSA_physical_habitat_metrics_descriptions.pdf}{NLA_Physical_Habitat_Metric_Descriptions.pdf}.
}
\description{
This function calculates the channel habitat 
portion of the physical habitat metrics for National Rivers 
and Streams Assessment (NRSA) data.  The function requires a 
data frame containing the thalweg data file.
}
\examples{
head(thalwegEx) 

# Must subset example dataset to create inputs, keeping only SITE
  #  and VALUE
# bChannelUnit
bChan <- subset(thalwegEx,PARAMETER=='CHANUNCD' & SAMPLE_TYPE=='PHAB_THAL',
select = c('SITE','VALUE'))
# wChannelUnit
wChan <- subset(thalwegEx,PARAMETER=='CHANUNCD' & SAMPLE_TYPE=='PHAB_THALW',
select = c('SITE','VALUE'))

chanHabOut <- nrsaChannelHabitat(bChannelUnit=bChan, wChannelUnit=wChan)
head(chanHabOut)
}
\author{
Curt Seeliger \email{Seeliger.Curt@epa.gov}\cr
Tom Kincaid \email{Kincaid.Tom@epa.gov}
}
