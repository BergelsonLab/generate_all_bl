# generate_all_bl

Generating a new set of all_basiclevel files
gather all basiclevel csv files in one folder using collect/gbl_paths.py. This script takes three arguments: the audio path file path_files/audiobl_directories.txt, the video path file path_files/videobl_directories.txt, and the output directory: Seedlings/Code/blab/all_bl/MM-DD-YY (with MM-DD-YY the date at which the gbl.py script is run)
open generate_all_bl.R in RStudio (a version of it is in Seedlings/Code/blab/generate_all_bl)
change the date line 14 to reflect the date of the version you want to create
Make a new directory in blab called "output_abl_MM-DD-YY" and within that directory, make a subdirectory called "basiclevel_bymonth"
Run the R script
This will generate the separate by-month audio/video basic_level csv's, and all_audio/all_video.csv's in addition to all_basiclevel.csv
Once you have the "all_basiclevel.csv" and "all_basiclevel.feather" generated in your output folder, you can copy them into all_basiclevel (replacing the old version). You also need to take the following two steps:
