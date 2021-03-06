library(blabr)
library(feather)
library(tidyverse)

##########################################################
#  The default paths listed here are the ones pointing   #
#  to input/output folders in Seedlings/Code/blab, which #
#  is also where a copy of this script lives. If         #
#  you need to run this script in some other location,   #
#  or want to set different input/outputs, you need to   #
#  set the following paths yourself.                     #
##########################################################

date_collect <- '07-31-19'
# folder with all the individual basiclevel csv's
all_bl_dir <- paste("/Volumes/pn-opus/Seedlings/Code/blab/all_bl/", date_collect, sep='')
#all_bl_dir <-"Z:/Seedlings/Code/blab/all_bl/01-28-19" #for Charlotte's windows computron

# folder to output the by-month csv's to
per_month_output_dir <- paste("/Volumes/pn-opus/Seedlings/Code/blab/output_abl_",date_collect,"/basiclevel_bymonth", sep='')
# per_month_output_dir <- "Z:/Seedlings/Code/blab/output_abl_012819/basiclevel_bymonth/"

# all_audio.csv output
all_audio_out <- paste("/Volumes/pn-opus/Seedlings/Code/blab/output_abl_",date_collect,"/all_audio.csv",sep='')
#all_audio_out <- "Z:/Seedlings/Code/blab/output_abl_012819/all_audio.csv"

# all_video.csv output
all_video_out <- paste("/Volumes/pn-opus/Seedlings/Code/blab/output_abl_",date_collect,"/all_video.csv",sep='')
#all_video_out <- "Z:/Seedlings/Code/blab/output_abl_012819/all_video.csv"

# all_basiclevel output name without extension (it will add the .csv and .feather)
all_bl_out <- "../output/all_basiclevel_with_na"
all_bl_out <- paste("/Volumes/pn-opus/Seedlings/Code/blab/output_abl_",date_collect,"/all_basiclevel",sep='')
#all_bl_out <- "Z:/Seedlings/Code/blab/output_abl_012819/all_basiclevel"

############################
# where the magic happens: #
############################

# audio by month
audiomonths <- concat_month_bl(all_bl_dir, per_month_output_dir, "audio")
# all audio
# filtering out pho lines manually here. The best solution would be for them to not end up here in the first place
audiostats <- concat_all_bl(audiomonths, all_audio_out) %>% dplyr::filter(!grepl("%pho"), object)

# video by month
videomonths <- concat_month_bl(all_bl_dir, per_month_output_dir, "video")
# all video
# Again, manually filter out pho lines here.
videostats <- concat_all_bl(videomonths, all_video_out) %>% dplyr::filter(!grepl("%pho"), object)



# all basiclevel
all_bl_NA <- join_full_audio_video(audiostats, videostats, all_bl_out, keep_na=TRUE)
all_bl <- join_full_audio_video(audiostats, videostats, all_bl_out)
# if there were errors, run this to print report
write.csv(all_bl, "problems.csv")
# write_feather(all_bl_NA, "Z:/Seedlings/Code/blab/all_basiclevel/all_basiclevel_NA.feather")

# read in abl
abl <- read_csv(paste(all_bl_out, ".csv", sep=''))

 # retrieve annotid values that appear at least twice
duplicates <- abl %>%
  group_by(annotid) %>% 
  count() %>% 
  filter(n>1)


merged_dup_abl <- duplicates %>%
  merge(abl, how="left")

# retrieve annotations for which there is no annotid
abl %>% 
  filter(is.na(annotid))

