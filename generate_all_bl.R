library(blabr)

##########################################################
#  The default paths listed here are the ones pointing   #
#  to input/output folders in Seedlings/Code/blab, which #
#  is also where a copy of this script lives. If         #
#  you need to run this script in some other location,   #
#  or want to set different input/outputs, you need to   #
#  set the following paths yourself.                     #
##########################################################

# folder with all the individual basiclevel csv's
all_bl_dir <- "/Volumes/pn-opus/Seedlings/Code/blab/all_bl/01-28-19"

# folder to output the by-month csv's to
per_month_output_dir <- "/Volumes/pn-opus/Seedlings/Code/blab/output/basiclevel_bymonth"

# all_audio.csv output
all_audio_out <- "/Volumes/pn-opus/Seedlings/Code/blab/output/all_audio.csv"

# all_video.csv output
all_video_out <- "/Volumes/pn-opus/Seedlings/Code/blab/output/all_video.csv"

# all_basiclevel output name without extension (it will add the .csv and .feather)
#all_bl_out <- "../output/all_basiclevel_with_na"
all_bl_out <- "/Volumes/pn-opus/Seedlings/Code/blab/output/all_basiclevel"


############################
# where the magic happens: #
############################

# audio by month
audiomonths <- concat_month_bl(all_bl_dir, per_month_output_dir, "audio")
# all audio
audiostats <- concat_all_bl(audiomonths, all_audio_out)

# video by month
videomonths <- concat_month_bl(all_bl_dir, per_month_output_dir, "video")
# all video
videostats <- concat_all_bl(videomonths, all_video_out)

# all basiclevel
#all_bl <- join_full_audio_video(audiostats, videostats, all_bl_out, keep_na=TRUE)
all_bl <- join_full_audio_video(audiostats, videostats, all_bl_out)
# if there were errors, run this to print report
write.csv(all_bl, "problems.csv")
