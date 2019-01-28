import csv
import os


input_dir = "audio_bl_out"


files = [os.path.join(input_dir, x) for x in os.listdir(input_dir)]

results = []

for file in files:
    if file.endswith(".csv"):
        with open(file, "rU") as input:
            print file
            reader = csv.reader(input)
            reader.next()
            prefix = os.path.basename(file)[:5]
            sm = prefix.split("_")
            for row in reader:
                results.append([sm[0]] + [sm[1]] + row)


header = ["subj", "month", "tier", "word", "utterance_type",
          "object_present", "speaker", "timestamp", "pho",
          "basic_level"]

with open("all_bl_chi_withpho.csv", "wb") as out:
    writer = csv.writer(out)
    writer.writerow(header)
    writer.writerows(results)

