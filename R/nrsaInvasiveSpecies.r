#' @export
#' @title Calculate NRSA Invasive Species Metrics
#' @description This function calculates the invasive species 
#' portion of the physical habitat metrics for National Rivers and 
#' Streams Assessment (NRSA) data.  The function requires a data 
#' frame containing the invasive species/legacy riparian trees data file.
#' @param ... named arguments consisting of data frames containing presence/absence
#' data for individual invasive taxa.  Each dataframe is expected to 
#' have the following columns:
#' \itemize{
#'  \item SITE integer or character specifying the site visit
#'  \item VALUE character values of 'X' or 'Y' signifying presence 
#'  and '' or 'N' signifying absence. 
#'  }
#'  The names of each argument (data frames) are used
#'  to create the names of the resulting metrics using a prefix of 'f_' for 
#'  the fraction of the reach containing a taxon.  
#'  The use of 'NONE' as a name is prohibited as that is left for use to 
#'  show where no invasives were found, and is thus not included in the 
#'  calculations of ip_score
#' @param isUnitTest Logical argument to determine whether errors should be ignored.
#' Should only be used for running a unit test. Default value is FALSE.
#' @return Either a data frame when metric calculation is successful 
#' or a character string containing an error message when metric 
#' calculation is not successful.  The data frame contains the 
#' following columns:
#' \itemize{
#' \item SITE - universal ID value
#' \item METRIC - metric name
#' \item VALUE - metric value
#' }
#' Metrics calculated include all invasive species input names with
#' the prefix 'f_', representing the fraction of the reach containing
#' the taxon. The metric f_none represents the fraction of the reach 
#' with no invasives.
#' 
#' Descriptions for all NRSA metrics can be found at:
#' \href{https://github.com/USEPA/aquamet/blob/master/inst/NRSA_physical_habitat_metrics_descriptions.pdf}{NLA_Physical_Habitat_Metric_Descriptions.pdf}.
#' @author Curt Seeliger \email{Seeliger.Curt@epa.gov}\cr
#' Tom Kincaid \email{Kincaid.Tom@epa.gov}
#' 
#' @examples
#' head(invlegEx,10)
#' # This example has no invasive species present
#' 
#' noinv <- subset(invlegEx, PARAMETER=='NO_INVASIVES',
#'   select = c(SITE,VALUE))     
#'    
#' invasiveOut <- nrsaInvasiveSpecies(none = noinv)
#' 
#' invasiveOut
#' 

nrsaInvasiveSpecies <- function(..., isUnitTest=FALSE) {

################################################################################
# Function: nrsaInvasiveSpecies
# Title: Calculate NRSA Invasive Species Metrics
# Programmers: Suzanne San Romani
#              Curt Seeliger
#              Tom Kincaid
# Date: February 10, 2010
# Description:
#   This function calculates the invasive species portion of the physical
#   habitat metrics for National Rivers and Streams Assessment (NRSA) data.  The
#   function requires a data frame containing the invasive species/legacy
#   riparian trees data file.
# Metrics:
# Function Revisions:
#   02/10/10 ssr: Created.
#   03/23/10 cws: Moved creation of test dataframes into separate functions.
#   03/25/10 cws: Changed diff() calls to dfCompare().
#   06/24/10 cws: Modified to handle odd case when transect has NO_INVASIVES
#            marked as well as an invasive species marked.  This shouldn't,
#            in the hopeful sense, make it through QA but we can assume a
#            species marked as present actually is present and safely ignore
#            the NO_INVASIVES check in these cases.
#   09/16/10 cws: Removing hardcoding of NRSA database name, using NRSAdbName
#            instead.
#   11/02/10 cws: Modified to handle datasets with no NO_INVASIVES boxes
#            checked.  Updated unit test to check for this case.
#   07/26/12 tmk: Removed use of ODBC data connection and replaced with data
#            input from csv files using a call to function read.csv.  Added
#            argument tbl to the function to identify name of the data file.
#            Added argument NRSAdir to the function to identify the directory
#            from which the data file is read and to which the output metrics
#            file is written.
#   12/20/12 tmk: Modified data input to use a data frame containing the data
#            file rather than a csv file.  Modified output to be a data frame
#            rather than a csv file.  Removed RUnit functions.
#   01/11/13 tmk: Inserted code to convert factors in the input data frame to
#            character variables.
#   12/08/15 cws Updated calling interface, with corresponding update to unit test.
#            Uses elipsis argument (...) to allow inclusion of any species in the
#            calculations. Argument names are used to create the resulting
#            metric names (f_argname1, f_argname2, etc.).  If there is an argument
#            named 'none', those values will not be included in the ip_score 
#            calculations.  Additionally, values for individual species are now
#            returned when they are zero; previously these values were not 
#            included in the metrics.
#    2/25/16 cws Documenting arguments in comments at top. Moved definition of
#            nrsaInvasiveSpecies.singleSpeciesTest to nrsaInvasiveSpeciesTest.r
#            Removed old code.
#    3/18/19 cws Using aquametStandardizeArgument; modified unit test accordingly.
#    6/12/24 cws Removed calls to ddply, using group_by/summarise. Modified to
#            return dataframe with zero rows instead of NULL when no data is
#            provided.
#
# ARGUMENTS
# ...       named arguments consisting of dataframes containing presence/absence
#           data for individual invasive taxa.  Each dataframe is expected to 
#           have the following columns:
#               SITE        integer or character specifying the site visit
#               VALUE       character values of 'X' or 'Y' signifying presence
#                           and '' or 'N' signifying absence.
#           The names of each argument are used to create the names of the
#           resulting metrics using a prefix of 'f_' for the fraction of the
#           reach containing a taxon.  The use of 'NONE' as a name is prohibited
#           as that is left for use to show where no invasives were found, and
#           is thus not included in the calculations of ip_score
#
# Output:
#   Either a data frame when metric calculation is successful or a character
#   string containing an error message when metric calculation is not
#   successful.  The data frame contains the following columns:
#     SITE - universal ID value
#     METRIC - metric name
#     VALUE - metric value
# Other Functions Required:
#   intermediateMessage - print messages generated by the metric calculation
#      functions
################################################################################

    # Sanity checks: make sure all arguments are named, perhaps by creating names 
    # for unnamed arguments.  If the 4th argument has no name, call it 'unknown4'

    # Make sure all arguments are NULL or have columns SITE, TRANSECT, VALUE
    intermediateMessage('Invasive plant mets', loc='start')
    speciesList <- list(...)
    allMets <- data.frame(SITE=1L, METRIC='', VALUE='', stringsAsFactors=FALSE)[0,] # NULL
    if(length(speciesList) > 0) {
        for(spName in names(speciesList)) {
            intermediateMessage(sprintf('. %s', spName))
            spData <- aquametStandardizeArgument(speciesList[[spName]]
                                                ,struct = list(SITE=c('integer','character'), VALUE=c('character'))
                                                ,legalValues = list(VALUE = c(NA,'','N','X','Y'))
                                                ,stopOnError = !isUnitTest
                                                )
            if(is.null(spData)) next;
            spMets <- nrsaInvasiveSpecies.singleSpecies(spData) %>%
                      mutate(METRIC=sprintf('f_%s', spName))
            allMets <- rbind(allMets, spMets)
        }
        
        intermediateMessage('. ip_score')
        ipScore <- nrsaInvasiveSpecies.ip_score(allMets)
        allMets <- rbind(allMets, ipScore) %>% data.frame()
    }

    intermediateMessage(' Done.', loc='end')

    return(allMets)
}


nrsaInvasiveSpecies.singleSpecies <- function(spData) 
# Determines average occurence for a single species. 
{
    # Normalize presence/absence data, but allow for use with cover values as 
    # such as 0.25 as well.
    rc <- spData %>% 
          mutate(VALUE = as.numeric(ifelse(VALUE %in% c('X','Y'), 1,
                                    ifelse(VALUE %in% c('N',''),  0, VALUE
                                    ))
                                   )) %>%
          # ddply('SITE', summarise                             # OLD CODE
          #      ,VALUE = protectedMean(VALUE, na.rm=TRUE)
          #      )
          group_by(SITE) %>%                                    # NEW CODE
          summarise(VALUE = protectedMean(VALUE, na.rm=TRUE)) %>%
          data.frame()
    
    return(rc)
}


nrsaInvasiveSpecies.ip_score <- function(individualMets)
# Calculate ip_score as the sum of occurrences of individual species, not 
# including f_none if it appears.
{   
    # Handle times when data provided has zero rows.
    if(is.null(individualMets)) 
        return(NULL)
    
    # sitesWithSpecies <- ddply(subset(individualMets, METRIC!='f_none')  # OLD CODE
    #                     ,c('SITE')
    #                     ,summarise
    #                     ,VALUE = protectedSum(VALUE, na.rm=TRUE)
    #                     ,METRIC = 'ip_score'
    #                     )
    sitesWithSpecies <- individualMets %>%                                # NEW CODE
                        subset(METRIC != 'f_none') %>% 
                        group_by(SITE) %>%
                        summarise(VALUE = protectedSum(VALUE, na.rm=TRUE)) %>%
                        mutate(METRIC = 'ip_score')
    sitesWithoutSpecies <- subset(individualMets
                                 ,METRIC == 'f_none' & 
                                  #VALUE == 1 & 
                                  SITE %nin% sitesWithSpecies$SITE
                                 )
    if(nrow(sitesWithoutSpecies) == 0) {
        sitesWithoutSpecies <- NULL
    } else {
        sitesWithoutSpecies <- mutate(sitesWithoutSpecies
                                     ,VALUE = 0
                                     ,METRIC = 'ip_score'
                                     )
    }

    rc <- rbind(sitesWithSpecies, sitesWithoutSpecies) %>% data.frame()
    return(rc)
}

# end of file