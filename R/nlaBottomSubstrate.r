#' @export
#' @title Calculate NLA Bottom Substrate Metrics
#' @description This function calculates the bottom substrate portion of the physical
#' habitat metrics for National Lakes Assessment (NLA) data.  
#' @param bedrock A data frame containing bedrock class values, 
#' with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE an integer value, or character value that is castable to an 
#' integer, from 0-4 containing the bedrock bottom substrate cover
#' category.
#' }
#' @param boulder A data frame containing boulder class values, 
#' with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE an integer value, or character value that is castable to an 
#' integer, from 0-4 containing the boulder bottom substrate cover
#' category.
#' }
#' @param color A data frame containing bottom substrate color values, 
#' with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE a character string with possible values of BLACK, GRAY,
#' BROWN, RED, or OTHER_XXX representing the bottom substrate color category.
#' }
#' @param cobble A data frame containing cobble bottom substrate class 
#' values, with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE an integer value, or character value that is castable to an 
#' integer, from 0-4 containing the cobble bottom substrate cover
#' category.
#' }
#' @param gravel A data frame containing gravel bottom substrate class 
#' values, with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE an integer value, or character value that is castable to an 
#' integer, from 0-4 containing the gravel bottom substrate cover
#' category.
#' }
#' @param odor A data frame containing bottom substrate odor class 
#' values, with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE a character string with possible values of NONE, CHEMICAL,
#' OIL, ANOXIC, H2S, or OTHER_XXX representing the bottom substrate odor category.
#' } 
#' @param organic A data frame containing organic bottom substrate class 
#' values, with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE an integer value, or character value that is castable to an 
#' integer, from 0-4 containing the organic bottom substrate cover
#' category.
#' }
#' @param sand A data frame containing sand bottom substrate class 
#' values, with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE an integer value, or character value that is castable to an 
#' integer, from 0-4 containing the sand bottom substrate cover
#' category.
#' }
#' @param silt A data frame containing silt bottom substrate class 
#' values, with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE an integer value, or character value that is castable to an 
#' integer, from 0-4 containing the silt bottom substrate cover
#' category.
#' }
#' @param wood A data frame containing wood bottom substrate class 
#' values, with the columns:
#' \itemize{
#' \item SITE an integer or character value identifying a single site 
#' visit.
#' \item STATION a character value identifying the station within the SITE
#' \item VALUE an integer value, or character value that is castable to an 
#' integer, from 0-4 containing the wood bottom substrate cover
#' category.
#' }
#' @param dataInformation a data frame containing substrate cover category 
#' values (VALUE), the lower proportional cover value for each category (cover),
#' and an indicator variable of presence of a substrate type for each category.
#' The default values are:
#' \itemize{
#' \item value '0', '1', '2', '3', '4', NA
#' \item weights 0, 0.05, 0.25, 0.575, 0.875, NA
#' \item presence 0, 1, 1, 1, 1, NA
#' }  
#' @param classInformation a data frame containing substrate class names (CLASS)
#' and corresponding geometric mean of diameter ranges in mm (diam), as well as
#' an indicator of whether to include the class in estimates of substrate size
#' for the site. 
#' The default values are: 
#' \itemize{
#' \item name 'BEDROCK', 'BOULDERS','COBBLE', 'GRAVEL', 'SAND', 'SILT', 
#' 'ORGANIC', 'WOOD'
#' \item characteristicDiameter 5656.854, 1000, 126.4911, 11.31371, 0.3464102, 0.007745967, 
#' NA, NA  
#' \item inPopulationEstimate TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE
#' } 
#' @param isUnitTest Logical argument to determine whether errors should be ignored.
#' Should only be used for running a unit test. Default value is FALSE.
#' @return Either a data frame when metric calculation is successful or a 
#' character string containing an error message when metric calculation 
#' is not successful. The data frame contains the following columns:
#' \itemize{ 
#'     \item SITE - unique site visit identifier
#'     \item METRIC - metric name
#'     \item VALUE - metric value
#'       }
#' The output metrics include:
#' BSFPBEDROCK, BSFPBOULDERS, BSFPCOBBLE, BSFPGRAVEL, BSFPORGANIC, BSFPSAND,
#' BSFPSILT, BSFPWOOD, BSISTAVARIETY, BSISITEVARIETY, BSFCBEDROCK, BSFCBOULDERS,
#' BSFCCOBBLE, BSFCGRAVEL, BSFCORGANIC, BSFCSAND, BSFCSILT, BSFCWOOD, 
#' BSVBEDROCK, BSVBOULDERS, BSVCOBBLE, BSVGRAVEL, BSVORGANIC, BSVSAND,      
#' BSVSILT, BSVWOOD, BSNBEDROCK, BSNBOULDERS, BSNCOBBLE, BSNGRAVEL, BSNORGANIC, 
#' BSNSAND, BSNSILT, BSNWOOD, BSXLDIA, BSVLDIA, BS16LDIA, BS25LDIA, BS50LDIA, 
#' BS75LDIA, BS84LDIA, BSOPCLASS, BSOFCLASS, BSFBLACK, BSFBROWN, BSFGRAY, BSFRED, 
#' BSFOTHERCOLOR, BSNCOLOR, BSOCOLOR, BSFANOXIC, BSFCHEMICAL, BSFH2S, BSFNONEODOR,
#' BSFOTHERODOR, BSFOIL, BSNODOR, BSOODOR 
#' 
#' Descriptions for all NLA metrics can be found at:
#' \href{https://github.com/USEPA/aquamet/blob/master/inst/NLA_physical_habitat_metrics_descriptions.pdf}{NLA_Physical_Habitat_Metric_Descriptions.pdf}.
#' 
#' @author Curt Seeliger \email{Seeliger.Curt@epa.gov}\cr
#' Tom Kincaid \email{Kincaid.Tom@epa.gov}
#' @examples
#'   head(nlaPhab)
#'   
#'   # Must subset example dataset to create inputs, keeping only SITE, STATION,
#'   #  and VALUE
#'   bedrock <- subset(nlaPhab,PARAMETER=='BS_BEDROCK',select=-PARAMETER)
#'   boulder <- subset(nlaPhab,PARAMETER=='BS_BOULDER',select=-PARAMETER)
#'   color <- subset(nlaPhab,PARAMETER=='BS_COLOR',select=-PARAMETER)
#'   cobble <- subset(nlaPhab,PARAMETER=='BS_COBBLE',select=-PARAMETER)
#'   gravel <- subset(nlaPhab,PARAMETER=='BS_GRAVEL',select=-PARAMETER)
#'   odor <- subset(nlaPhab,PARAMETER=='ODOR',select=-PARAMETER)
#'   organic <- subset(nlaPhab,PARAMETER=='BS_ORGANIC',select=-PARAMETER)
#'   sand <- subset(nlaPhab,PARAMETER=='BS_SAND',select=-PARAMETER)
#'   silt <- subset(nlaPhab,PARAMETER=='BS_SILT',select=-PARAMETER)
#'   wood <- subset(nlaPhab,PARAMETER=='BS_WOOD',select=-PARAMETER)
#'   
#'   exBottomSubstrate <- nlaBottomSubstrate(bedrock, boulder, color,
#'   cobble, gravel, odor, organic, sand, silt, wood)
#'   
#'   head(exBottomSubstrate)
#'  

nlaBottomSubstrate <- function(bedrock=NULL
                              ,boulder=NULL
                              ,color=NULL
                              ,cobble=NULL
                              ,gravel=NULL
                              ,odor=NULL
                              ,organic=NULL
                              ,sand=NULL
                              ,silt=NULL
                              ,wood=NULL
                              ,dataInformation=data.frame(value	= c(NA, '0', '1', '2', '3', '4')
                       	                                 ,weights	= c(NA, 0, 0.05, 0.25, 0.575, 0.875)
					   	                                 ,presence= as.logical(c(NA, 0, 1, 1, 1, 1))
                       	                                 ,stringsAsFactors=FALSE
                       	                                 )
                              ,classInformation=data.frame(name=c('BEDROCK', 'BOULDERS'
                                                                 ,'COBBLE',  'GRAVEL'
                                                                 ,'SAND',    'SILT'
                                                                 ,'ORGANIC', 'WOOD'
                                                                 )
                                                          ,characteristicDiameter=c(gmean(c(4000,8000)), gmean(c(250,4000))
                                           	                                       ,gmean(c(64,250)),    gmean(c(2,64))
                                       	                                           ,gmean(c(0.06,2)),    gmean(c(0.001,0.06))
                       	                                                           ,NA,                  NA
                       	                                                           )
                                                          ,inPopulationEstimate = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)
                                                          ,stringsAsFactors=FALSE
                                                          )
                              ,isUnitTest = FALSE
                              ) {

################################################################################
# Function: nlaBottomSubstrate
# Title: Calculate NLA Bottom Substrate Metrics
# Programmers: Curt Seeliger
#              Tom Kincaid
# Date: September 19, 2008
# Description:
#   This function calculates the bottom substrate portion of the physical
#   habitat metrics for National Lakes Assessment (NLA) data.  The function
#   requires a data frame containing validated physical habitat data collected
#   using the NLA protocol.
# Function Revisions:
#   09/19/08 cws: Changed comments for how modalClass() is used. Removed
#            nonmineral substrate covers from particle size means, stdevs and
#            percentile calculations.
#   10/07/08 cws: quantile calculations using type 3 algorithm to mimic SAS 
#            results, according to R documentation.
#   10/14/08 cws: Cover values normalized at each station/subid prior to
#            metrics calculation.
#   10/16/08 cws: Adding calculation bsiVariety, previously missed.
#   10/17/08 cws: changed to use type 2 quantile calculation method, as this
#            actually matches SAS output using proc univariate.
#   10/21/08 cws: Correcting counts of missing parameters.  These are now zero.
#   10/30/08 cws: Renamed bsiVariety to bsiStaVariety and added bsiSiteVariety.
#   11/05/08 cws: Correcting normalization of mineral substrate covers on which
#            the percentiles are based; previous percentiles were based on
#            normalized values that were mixed with earlier values that included
#            nonmineral covers.
#   11/06/08 cws: Removing code for changing NA counts to zero.
#   02/27/09 cws: calculation of bsiSiteVariety corrected.
#   03/08/13 cws: Copied from 2007 study and renamed.
#   11/22/13 cws: Temporarily upcased column names when calling normalizeCover()
#            and then lowcasing them to allow calculations.
#   12/24/13 cws: Created unit test using 2007 data.
#   12/26/13 cws: Changed input data column names, upcased metric names, changed
#            output from wide to long.
#   12/30/13 cws: Regression test to 2007 results shows 666 total differences,
#            642 of which are due to 57 sites with no Bottom Substrate data and
#            another 19 sites with Refactored.
#   01/21/13 cws: Completed unit test.  Regression test to 2007 results shows
#            1506 differences due to floating point issues, and 3530 rows in
#            2007 values which are due to absent data and thus not in the
#            current output (BSV*, BSF*, etc.) or counts (BSN*) that were set to
#            zero.
#   02/20/14 cws: Changing expected coding of substrate color and odor (BS_COLOR 
#            and BS_ODOR) from 2007 to 2012 standard.  Unit tests modified 
#            accordingly using code which can be used as an example when 
#            processing 2007 data. 
#   06/12/14 tmk: Removed calls to the require() function.
#    7/07/17 cws Renamed from metsBottomSubstrate.r to nlaBottomSubstrate.r and
#            modified for updated calling interface of nlaBottomSubstrate.
#    7/10/17 cws Changed calculation of individual ODOR metrics to include NA
#            as possible value; this has the effect of these metrics having a
#            value of 0 when those odors do not exist rather than be absent 
#            from the output. Also handling case of all zero ODOR frequencies
#            to result in mode of '' rather than list of all possible ODOR values
#            due to all zeros being treated as ties. The effect of these changes
#            is to add rows of BSF* odor values that are 0, and change that one
#            peculiar case of all zero frequencies tying as the mode.
#    7/11/17 cws Split substrate argument into individual classes, to be consistent
#            with general interface. Unit test updated as well. Removed BS_ prefix
#            from substrate class values. Changed name of interior function
#            addParameter to addClass.
#    7/17/17 cws Changed boulders argument to boulder, so all the classes are singular.
#    3/19/19 cws Added isUnitTest argument for consistency.
#    3/21/19 cws Added validation checks of data and metadata; using metadata
#            args in data validation.
#    3/28/19 cws Standardized metadata argument naming
#   12/31/19 cws Allowing SITE to be character as well as integer in all arguments.
#   11/16/23 cws Modified station-level summaries in population estimates to be
#            sum of weighted diameters rather than mean of those values. Modified
#            bsxldia_wfc as well to be sum of diameters weighted by site level
#            fractional cover instead of the mean of those values.
#   11/30/23 cws Using protectedSum and protectedMean in nlaBottomSubstrate.populationEstimates
#            to avoid station means of 0 instead of NA when mineral substrate
#            covers are all zero or missing at a station. Handles edge cases when
#            no mineral substrate covers occur at a station.
#   12/06/23 cws Removed BS prefix from nlaBottomSubstrate.populationEstimates
#            metrics names so that function can be used with shoreline substrate
#            data as well. Those prefixes are now added by the calling environement.
#    1/18/24 cws Reverted from list() to rbind() when creating the final 'mets'
#            object to return from nlaBottomSubstrate().
#
# Arguments:
#   df = a data frame containing bottom substrate data.  The data frame must
#     include columns that are named as follows:
#       SITE - universal ID value, which uniquely identifies the site location, 
#             date of visit, visit order, habitat type, etc. for which metrics 
#             will be calculated.  For NLA, site ID, year and visit number are
#             used for this purpose.
#       STATION - the subordinate ID value, which identifies the location,
#               habitat type, order of occurence, etc. within a single SITE.
#               For NLA, transect is used for this purpose.
#       CLASS - substrate class name, which identifies the variables used in
#               calculations. In wide data frame format, this argument
#               would be used to name columns.  It is assumed that this
#               argument has the following values: BS_BEDROCK, BS_BOULDERS,
#               BS_COBBLE, BS_GRAVEL, BS_SAND, BS_SILT, BS_ORGANIC, BS_WOOD,
#               BS_COLOR, and BS_ODOR.
#       VALUE - parameter values, which are the values used in calculations.
# Output:
#   A data frame that contains the following columns:
#     SITE - universal ID value
#     METRIC - metric name
#     VALUE - metric value
# Other Functions Required:
#   intermediateMessage - print messages generated by the metric calculation
#      functions
################################################################################

    # Print initial messages
    intermediateMessage('NLA bottom substrate metrics', loc='start')
  
    # Standardize arguments, then combine them into single dataframe as expected
    # in the rest of the function
    addClass <- function(df, ...) {
        
        args <- list(...)
        
        if(is.null(args)) return(NULL)
        else if(all(is.na(args))) return(NULL)
        
        rc <- df %>% mutate(CLASS=args[[1]])
        return(rc)
        
    }
    
    dataInformation <- aquametStandardizeArgument(dataInformation
                                                 ,struct = list(value=c('character','integer'), weights='double', presence=c('logical','integer'))
                                                 ,legalValues = list(value=c(NA,'','0','1','2','3','4'), presence=c(NA, FALSE, TRUE))
                                                 ,rangeLimits = list(weights=c(0,1))
                                                 ,stopOnError = !isUnitTest
                                                 )
    classInformation <- aquametStandardizeArgument(classInformation
                                                  ,struct = list(name=c('character'), characteristicDiameter='double', inPopulationEstimate=c('logical','integer'))
                                                  ,legalValues = list(name=c(NA, ''
                                                                            ,'BEDROCK', 'BOULDERS'
                                                                            ,'COBBLE',  'GRAVEL'
                                                                            ,'SAND',    'SILT'
                                                                            ,'ORGANIC', 'WOOD'
                                                                            )
                                                                     ,inPopulationEstimate=c(NA, FALSE, TRUE)
                                                                    )
                                                  ,stopOnError = !isUnitTest
                                                  )

    color <- aquametStandardizeArgument(color, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues=list(VALUE=c('^(|BLACK|BROWN|GRAY|OTHER.*|RED)$', isrx=TRUE)), stopOnError = !isUnitTest)
    odor <- aquametStandardizeArgument(odor, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues=list(VALUE=c('^(|ANOXIC|CHEMICAL|H2S|NONE|OTHER.*|OIL)$', isrx=TRUE)), stopOnError = !isUnitTest)
    bedrock <- aquametStandardizeArgument(bedrock, ifdf=addClass, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues = list(VALUE=c(NA,'',dataInformation$value)), 'BEDROCK', stopOnError = !isUnitTest)
    boulder <- aquametStandardizeArgument(boulder, ifdf=addClass, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues = list(VALUE=c(NA,'',dataInformation$value)), 'BOULDERS', stopOnError = !isUnitTest)
    cobble <- aquametStandardizeArgument(cobble, ifdf=addClass, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues = list(VALUE=c(NA,'',dataInformation$value)), 'COBBLE', stopOnError = !isUnitTest)
    gravel <- aquametStandardizeArgument(gravel, ifdf=addClass, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues = list(VALUE=c(NA,'',dataInformation$value)), 'GRAVEL', stopOnError = !isUnitTest)
    organic <- aquametStandardizeArgument(organic, ifdf=addClass, struct=list(SITE='integer', STATION='character', VALUE='character'), legalValues = list(VALUE=c(NA,'',dataInformation$value)), 'ORGANIC', stopOnError = !isUnitTest)
    sand <- aquametStandardizeArgument(sand, ifdf=addClass, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues = list(VALUE=c(NA,'',dataInformation$value)), 'SAND', stopOnError = !isUnitTest)
    silt <- aquametStandardizeArgument(silt, ifdf=addClass, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues = list(VALUE=c(NA,'',dataInformation$value)), 'SILT', stopOnError = !isUnitTest)
    wood <- aquametStandardizeArgument(wood, ifdf=addClass, struct=list(SITE=c('integer','character'), STATION='character', VALUE='character'), legalValues = list(VALUE=c(NA,'',dataInformation$value)), 'WOOD', stopOnError = !isUnitTest)

    substrateCovers <-dplyr::rename(dataInformation, VALUE=value, cover=weights)    
    substrateSizes <- dplyr::rename(classInformation, CLASS=name, diam=characteristicDiameter)

    substrate <- rbind(bedrock, boulder, cobble, gravel, organic, sand, silt, wood)
  	bsData <- nlaBottomSubstrate.setupForParticleCalculations(substrate, substrateCovers, substrateSizes)
# print(bsData %>% arrange(SITE, STATION, CLASS) %>% select(SITE, STATION, CLASS, VALUE, everything()) %>% head(20))
# print(bsData %>% arrange(SITE, STATION, CLASS) %>% select(SITE, STATION, CLASS, VALUE, everything()) %>% tail(20))
#print('bsDdata'); print(str(bsData)); print(bsData %>% subset(SITE==7519) %>% arrange(SITE, STATION, CLASS))
  	intermediateMessage('.1')
  	indivPresence <- nlaBottomSubstrate.indivPresence(bsData)
  	intermediateMessage('.2')
  	variety <- nlaBottomSubstrate.variety(bsData)
  	intermediateMessage('.3')
  	indivCover <- nlaBottomSubstrate.indivCover(bsData)
  	intermediateMessage('.4')
  	populationEstimates <- nlaBottomSubstrate.populationEstimates(bsData, substrateSizes)
  	if(!is.null(populationEstimates)) 
  	    populationEstimates <- populationEstimates %>%
  	                           mutate(METRIC = paste0('BS', METRIC))
  	intermediateMessage('.5')
  	modeCover <- nlaBottomSubstrate.modeCover(indivPresence, indivCover)
  	intermediateMessage('.6')
	
# print(str(indivCover)); print(str(substrateSizes)); # DEBUG STUFF
# print(str(indivCover %>%
#   	               mutate(CLASS = sub('^BSFC(.+)$', '\\1', METRIC)) %>%
#   	               merge(substrateSizes %>% 
#   	                     select(CLASS, diam)
#   	                    ,by='CLASS'
#   	                    ,all.x=TRUE
#   	                    )))
# print(indivCover %>%
#   	               mutate(CLASS = sub('^BSFC(.+)$', '\\1', METRIC)) %>%
#   	               merge(substrateSizes %>% 
#   	                     select(CLASS, diam)
#   	                    ,by='CLASS'
#   	                    ,all.x=TRUE
#   	                    ) %>% subset(SITE %in% c(2008542, 6160)) )

  	bsxldia_wfc <- NULL
  	if(!is.null(indivCover)) {
      	bsxldia_wfc <- indivCover %>%
  	                   subset(METRIC %in% c('BSFCBEDROCK','BSFCBOULDERS','BSFCCOBBLE'
  	                                       ,'BSFCGRAVEL', 'BSFCSAND',    'BSFCSILT'
  	                                       )
  	                         ) %>%
      	               mutate(CLASS = sub('^BSFC(.+)$', '\\1', METRIC)) %>%
  	                   merge(substrateSizes %>% 
  	                         select(CLASS, diam)
  	                        ,by='CLASS'
  	                        ,all.x=TRUE
  	                        ) %>%
      	               subset(!(is.na(VALUE))) %>%
  	                   subset(VALUE > 0) %>%
  	                   group_by(SITE) %>%
  	                   summarise(VALUE = protectedSum(as.numeric(VALUE) * log10(diam)
  	                                                  ,na.rm=TRUE, nan.rm=TRUE, inf.rm=TRUE
  	                                                  )
  	                            ) %>%
      	               mutate(METRIC = 'BSXLDIA_WFC')
  	}
  	
# print( bsxldia_wfc %>% subset(SITE %in% c(2008542, 6160)) ) # DEBUG STUFF
  	intermediateMessage('.wfc')
	
  	indivColor <- nlaBottomSubstrate.indivColor(color)
  	intermediateMessage('.7')
  	modeColor <- nlaBottomSubstrate.modeColor(indivColor)
  	intermediateMessage('.8')
  
	
	indivOdor <- nlaBottomSubstrate.indivOdor(odor)
  	intermediateMessage('.9')
  	modeOdor <- nlaBottomSubstrate.modeOdor(indivOdor)
  	intermediateMessage('.10')
  
	
	mets <- rbind(indivPresence, variety, indivCover, populationEstimates, modeCover
			   	 ,indivColor, modeColor, indivOdor, modeOdor
			   	 )
  # mets <- list(indivPresence, variety, indivCover, populationEstimates, modeCover
  #              ,indivColor, modeColor, indivOdor, modeOdor
  #              ,bsxldia_wfc
  # ) %>% 
  #   lapply(names) %>% 
  #   print()
  
	intermediateMessage(' Done.', loc='end')
	
	return(mets)
}

#' @keywords internal
nlaBottomSubstrate.setupForParticleCalculations <- function(bsData, substrateCovers, substrateSizes)
# Prepares the input data for subsequent particle calculations, adding
# information for each substrate class.  
# Returns prepared data in a dataframe.
#
{
    if(is.null(bsData)) return (NULL)
    
  	bsData <- subset(bsData, CLASS %in% substrateSizes$CLASS)
    intermediateMessage('.a')

    # Set up recodings for presence, cover and characteristic diameter (both
  	# actual and logged)
	diameters <- mutate(substrateSizes, lDiam = log10(diam))
	
    preppedData <- bsData %>%
                   merge(substrateCovers, by='VALUE', all.x=TRUE) %>% 
                   merge(diameters, by='CLASS', all.x=TRUE)
    intermediateMessage('.b')

	return(preppedData)	
}

#' @keywords internal
nlaBottomSubstrate.indivPresence <- function(bsPresence)
# Calculate fractional presence of each substrate class
{
    if(is.null(bsPresence)) return (NULL)
    
  	tt <- aggregate(list(VALUE = bsPresence$presence)
                   ,list(SITE=bsPresence$SITE
                   		,CLASS=bsPresence$CLASS
                   		) 
                   ,mean, na.rm=TRUE
                   )
  	meanPresence <- within(tt, METRIC <- paste0('BSFP', CLASS)) %>% # gsub('^BS_(.+)$', 'BSFP\\1', CLASS)) %>% 
  	                select(SITE, METRIC, VALUE)

	return(meanPresence)
}

#' @keywords internal
nlaBottomSubstrate.variety <- function(bsData)	
# Calculate variety metrics: 
#     bsiStaVariety = mean number of substrate classes at each station.
#     bsiSiteVariety = total number of substrate classes present in site
# The number of substrate classes at a station is the sum of their presences.
# If any of these presences are missing, the sum will also be missing
{
    if(is.null(bsData)) return (NULL)
    
	tt <- aggregate(bsData$presence
                   ,list(SITE=bsData$SITE
                      	,STATION=bsData$STATION
                      	)
                   ,sum, na.rm=TRUE
                   )
	bsiStaVariety <- aggregate(list(VALUE = tt$x)
                           	  ,list(SITE=tt$SITE)
                              ,mean, na.rm=TRUE
                           	  )
  	bsiStaVariety$METRIC <- 'BSISTAVARIETY'

	
	tt <- subset(bsData, presence %in% 1)
	bsiSiteVariety <- aggregate(list(VALUE = tt$CLASS)
							   ,list(SITE=tt$SITE)
					   		   ,function(x) {
								   rc <- count(unique(x))
								   return(rc)
							    }
							   )
	bsiSiteVariety$METRIC <- 'BSISITEVARIETY'
							   
	rc <- rbind(bsiStaVariety, bsiSiteVariety)
	
	return(rc)
}
  
#' @keywords internal
nlaBottomSubstrate.indivCover <- function(bsData)
# calculate mean, stdev and counts of normalized characteristic cover values 
# of each substrate class.
{
    if(is.null(bsData)) return (NULL)
    
  	bscover <- normalizedCover(bsData, 'cover', 'normCover')
	intermediateMessage('.a')
	
  	tt <- aggregate(list(VALUE = bscover$normCover)
                   ,list(SITE=bscover$SITE
                      	,CLASS=bscover$CLASS
                      	) 
                   ,mean, na.rm=TRUE
                   )
	meanCover <- within(tt, METRIC <- paste0('BSFC', CLASS)) %>% # gsub('^BS_(.+)$', 'BSFC\\1', CLASS)) %>%
	             select(SITE, METRIC, VALUE)
	intermediateMessage('.b')
	
	tt <- aggregate(list(VALUE = bscover$normCover)
                   ,list(SITE=bscover$SITE
                      	,CLASS=bscover$CLASS
                      	) 
                   ,sd, na.rm=TRUE
                   )
	sdCover <- within(tt, METRIC <- paste0('BSV', CLASS)) %>% # gsub('^BS_(.+)$', 'BSV\\1', CLASS)) %>%
	           select(SITE, METRIC, VALUE)
  	intermediateMessage('.c')


  	tt <- aggregate(list(VALUE = bscover$normCover)
                   ,list(SITE=bscover$SITE
                      	,CLASS=bscover$CLASS
                      	) 
                   ,count
                   )
	nCover <- within(tt, METRIC <- paste0('BSN', CLASS)) %>% # gsub('^BS_(.+)$', 'BSN\\1', CLASS)) %>%
	          select(SITE, METRIC, VALUE)
  	intermediateMessage('.d')

	rc <- rbind(meanCover, sdCover, nCover)
	return(rc)
}

#' @keywords internal
nlaBottomSubstrate.populationEstimates <- function(bsData, substrateSizes)
# Calculations using characteristic diameters of the substrate are based
# on mean diameter*cover values at each transect.  Cover values are 
# normalized prior to their use as weights for these means.
#
{
    if(is.null(bsData)) return (NULL)
    
	# Determine normalized coversof mineral substrates, and use those to weight
	# the characteristic diameters for determining diameter percentiles at each 
	# site. If the cover of a substrate class is zero, change it to NA to remove
    # it from the calculation
    mineralCover <- bsData %>% 
                    mutate(cover = ifelse(cover==0, NA
                                  ,ifelse(!inPopulationEstimate, NA, cover
                                   ))
                          ) %>% select(setdiff(names(bsData),'normCover'))
  	mineralCover <- normalizedCover(mineralCover, 'cover', 'normCover')
	intermediateMessage('.a')

	mineralCover$wtDiam <- with(mineralCover, normCover * log10(diam) )
  	diamSubstrate <- aggregate(list(meanLDiam = mineralCover$wtDiam)
                              ,list(SITE=mineralCover$SITE
                                   ,STATION=mineralCover$STATION
                                   ) 
                              ,protectedSum, na.rm=TRUE
                              )
    intermediateMessage('.b')

    # # Calculate mean substrate size without cover-based weights. This is at least
    # # mathematically defensible, even if it does not include cover values
    # bsxldia_uwd <- mineralCover %>%
    #                subset(cover > 0) %>%
    #                mutate(lDiam = log10(diam)) %>%
    #                group_by(SITE) %>%
    #                summarise(VALUE = protectedMean(lDiam, na.rm=TRUE, inf.rm=TRUE, nan.rm=TRUE)) %>%
    #                mutate(METRIC = 'BSXLDIA_UWD')

	# Estimate measures of logged diameter populations: mean, sd, percentiles.
	# Percentiles use the type 2 algorithm because it matches what was used
	# in SAS by default.
  	tt <- aggregate(list(VALUE = diamSubstrate$meanLDiam)
                   ,list(SITE=diamSubstrate$SITE)
                   ,protectedMean, na.rm=TRUE
                   )
  	meanLDia <- within(tt, METRIC <- 'XLDIA')

    tt <- aggregate(list(VALUE = diamSubstrate$meanLDiam)
                   ,list(SITE=diamSubstrate$SITE)
                   ,sd, na.rm=TRUE
                   )
    sdLDia <- within(tt, METRIC <- 'VLDIA')

	intermediateMessage('.c')
	
	tt <- aggregate(list(VALUE = diamSubstrate$meanLDiam)
                   ,list(SITE=diamSubstrate$SITE)
                   ,quantile, 0.16, na.rm=TRUE, names=FALSE, type=2
                   )
    p16LDia <- within(tt, METRIC <- '16LDIA')

    tt <- aggregate(list(VALUE = diamSubstrate$meanLDiam)
                   ,list(SITE=diamSubstrate$SITE)
                   ,quantile, 0.25, na.rm=TRUE, names=FALSE, type=2
                   )
    p25LDia <- within(tt, METRIC <- '25LDIA')

    tt <- aggregate(list(VALUE = diamSubstrate$meanLDiam)
                   ,list(SITE=diamSubstrate$SITE)
                   ,quantile, 0.50, na.rm=TRUE, names=FALSE, type=2
                   )
    p50LDia <- within(tt, METRIC <- '50LDIA')

    tt <- aggregate(list(VALUE = diamSubstrate$meanLDiam)
                   ,list(SITE=diamSubstrate$SITE)
                   ,quantile, 0.75, na.rm=TRUE, names=FALSE, type=2
                   )
    p75LDia <- within(tt, METRIC <- '75LDIA')

    tt <- aggregate(list(VALUE = diamSubstrate$meanLDiam)
                   ,list(SITE=diamSubstrate$SITE)
                   ,quantile, 0.84, na.rm=TRUE, names=FALSE, type=2
                   )
    p84LDia <- within(tt, METRIC <- '84LDIA')

  	intermediateMessage('.d')
	
	rc <- rbind(meanLDia, sdLDia
	           ,p16LDia, p25LDia, p50LDia, p75LDia, p84LDia
#	           ,bsxldia_uwd
	           )

	return(rc)
}

#' @keywords internal
nlaBottomSubstrate.modeCover <- function(presences, covers)
# Determine most common substrate class by presence and by cover
# (requires same site visits in meanPresence and meanCover and in same order)
#
# ARGUMENTS:
# presences	dataframe containing substrate fractional presences for each site,
#            with columns SITE, METRIC, VALUE and METRIC is BSFPx.
# covers	dataframe containing substrate fractional presences for each site,
#            with columns SITE, METRIC, VALUE and METRIC is BSFCx.
#
{
    if(is.null(presences)) return (NULL)
    
	# mode by presence
	tt <- within(subset(presences, grepl('^BSFP', METRIC))
				,class <- gsub('^BSFP(.+)$', '\\1', METRIC)
				)
	tt <- within(tt, class <- capitalize(tolower(class)))	# TEMPORARY WHILE REFACTORING
	
	presMode <- modalClasses(tt, "class", "VALUE")
	presMode <- within(presMode
					  ,{METRIC <- 'BSOPCLASS'
						VALUE <- modalClasses
						modalClasses <- NULL
					   }
					  )

		
	# mode by cover class
	tt <- within(subset(covers, grepl('^BSFC', METRIC))
				,class <- gsub('^BSFC(.+)$', '\\1', METRIC)
				)
	tt <- within(tt, class <- capitalize(tolower(class)))	# TEMPORARY WHILE REFACTORING
	
	coverMode <- modalClasses(tt, "class", "VALUE")
	coverMode <- within(coverMode
					   ,{METRIC <- 'BSOFCLASS'
						 VALUE <- modalClasses
						 modalClasses <- NULL
					 	}
					   )
	
	rc <- rbind(presMode, coverMode)
  	return(rc)
}

#' @keywords internal
nlaBottomSubstrate.indivColor <- function(df)
# Determine largest fractional presence of each substrate color and sample size.
{
    if(is.null(df)) return (NULL)
    
	color <- subset(df, grepl('(BLACK|BROWN|GRAY|OTHER.*|RED)', VALUE))
	if(nrow(color) == 0) {
		intermediateMessage(" IMPROPER CODING OF BS_COLOR! (You might be using 2007 values) ")
	}
	
	black <- aggregate(list(VALUE = color$VALUE=='BLACK')
    		       	  ,list(SITE=color$SITE)
                 	  ,mean, na.rm=TRUE
                 	  )
	black$METRIC <- 'BSFBLACK'

	brown <- aggregate(list(VALUE = color$VALUE=='BROWN')
                 	  ,list(SITE=color$SITE)
                 	  ,mean, na.rm=TRUE
                 	  )
	brown$METRIC <- 'BSFBROWN'
					  
  	grey <- aggregate(list(VALUE = color$VALUE=='GRAY')
                   	 ,list(SITE=color$SITE) 
                   	 ,mean, na.rm=TRUE
                   	 )
	grey$METRIC <- 'BSFGRAY'
					 
  	red <- aggregate(list(VALUE = color$VALUE=='RED')
                  	,list(SITE=color$SITE) 
                   	,mean, na.rm=TRUE
                  	)
	red$METRIC <- 'BSFRED'
					
  	other <- aggregate(list(VALUE = grepl('^OTHER_', color$VALUE))
                 	  ,list(SITE=color$SITE)
                 	  ,mean, na.rm=TRUE
                 	  )
	other$METRIC <- 'BSFOTHERCOLOR'
					  
  	count <- aggregate(list(VALUE = I(color$VALUE))
                 	  ,list(SITE=color$SITE)
                 	  ,count
                 	  )
	count$METRIC <- 'BSNCOLOR'
					  
  	rc <- rbind(black, brown, grey, red, other, count)
  	return(rc)
}

#' @keywords internal
nlaBottomSubstrate.modeColor <- function(df)
# Determine color mode (most common color(s)) at each site.  Returns
# dataframe with mode of substrate color, alphabetizing ties.
#
# ARGUMENTS
# df		dataframe with fractional presences of individual colors
#             (i.e. BSFBLACK, BSFGREY, etc.)
#
{
    if(is.null(df)) return (NULL)
    
	indivFracs <- within(subset(df, METRIC != 'BSNCOLOR')
						,class <- gsub('^BSF(.+)$', '\\1', METRIC)
						)
	colorMode <- modalClasses(indivFracs, "class", "VALUE")	
	colorMode <- within(colorMode
					   ,{METRIC <- 'BSOCOLOR'
						 VALUE <- modalClasses
						 modalClasses <- NULL
						}
					   )

  	return(colorMode)
}

#' @keywords internal
nlaBottomSubstrate.indivOdor <- function(df)
# Determine fractional odor presences
{
    if(is.null(df)) return (NULL)
    
	odor <- subset(df, grepl('^(ANOXIC|CHEMICAL|H2S|NONE|OTHER.*|OIL)$', VALUE) | is.na(VALUE))
	if(nrow(odor) == 0) {
		intermediateMessage(" IMPROPER CODING OF ODOR! (You might be using 2007 values) ")
    }
				   
  	tt <- aggregate(list(VALUE = odor$VALUE %in% 'ANOXIC')
                   ,list(SITE = odor$SITE)
                   ,mean, na.rm=TRUE
                   )
	anoxic <- within(tt, METRIC <- 'BSFANOXIC')

  	tt <- aggregate(list(VALUE = odor$VALUE %in% 'CHEMICAL')
                   ,list(SITE = odor$SITE)
                   ,mean, na.rm=TRUE
                   )
  	chem <- within(tt, METRIC <- 'BSFCHEMICAL')

  	tt <- aggregate(list(VALUE = odor$VALUE %in% 'H2S')
                   ,list(SITE = odor$SITE)
                   ,mean, na.rm=TRUE
                   )
    h2s <- within(tt, METRIC <- 'BSFH2S')

  	tt <- aggregate(list(VALUE = odor$VALUE %in% 'NONE')
                   ,list(SITE = odor$SITE)
                   ,mean, na.rm=TRUE
                   )
  	none <- within(tt, METRIC <- 'BSFNONEODOR')

  	tt <- aggregate(list(VALUE = grepl('^OTHER', odor$VALUE))
                   ,list(SITE = odor$SITE)
                   ,mean, na.rm=TRUE
                   )
    other <- within(tt, METRIC <- 'BSFOTHERODOR')

    tt <- aggregate(list(VALUE = odor$VALUE %in% 'OIL')
                   ,list(SITE = odor$SITE)
                   ,mean, na.rm=TRUE
                   )
    oil <- within(tt, METRIC <- 'BSFOIL')

    tt <- aggregate(list(VALUE = I(odor$VALUE))
                   ,list(SITE = odor$SITE)
                   ,count
                   )
    count <- within(tt, METRIC <- 'BSNODOR')

    rc <- rbind(anoxic, chem, h2s, none, other, oil, count) %>%
          mutate(VALUE = ifelse(is.nan(VALUE), NA, VALUE))

  return(rc)
}

#' @keywords internal
nlaBottomSubstrate.modeOdor <- function(df)
# Determine most common substrate odor
{
    if(is.null(df)) return (NULL)
    
# 	indivFracs <- within(subset(df, METRIC !='BSNODOR')
# 		  			  	,class <- ifelse(METRIC == 'BSFNONEODOR', 'NONE'
# 					   			 ,ifelse(METRIC == 'BSFOTHERODOR', 'OTHER'
# 							  	 	  	,gsub('^BSF(.+)$', '\\1', METRIC)
# 					 			  ))
#   					  	)
# 	tt <- modalClasses(indivFracs, "class", "VALUE")	
# 	odorMode <- within(tt
# 					  ,{METRIC <- 'BSOODOR'
# 						VALUE <- modalClasses
# 						modalClasses <- NULL
# 					   }
# 					  )
	odorMode <- df %>%
	            subset(METRIC != 'BSNODOR') %>%
	            mutate(class = ifelse(METRIC == 'BSFNONEODOR', 'NONE'
					   		  ,ifelse(METRIC == 'BSFOTHERODOR', 'OTHER'
							         ,gsub('^BSF(.+)$', '\\1', METRIC)
					 		   ))
					  ,VALUE = ifelse(VALUE %in% 0, NA, VALUE)          # NA frequencies are not included in mode, this keeps case where all frequencies are zero to not show up as ties
					  ) %>%
	            modalClasses("class", "VALUE") %>%
	            mutate(METRIC = 'BSOODOR'
					  ,VALUE = modalClasses
					  ,modalClasses = NULL
					  )
					  
	return(odorMode)
}

# end of file