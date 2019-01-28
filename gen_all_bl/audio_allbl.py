import pyclan as pc
import csv
import os


input_dir = "../collect/all_cha"
# input_dir = "problems"
output_dir = "audio_bl_out2"

header = ["tier", "word", "utterance_type",
          "object_present", "speaker",
          "timestamp", "pho", "basic_level"]

def output_bl(f, annots):
    with open("{}_audio_sparse_code_processed.csv".format(os.path.join(output_dir, f[:5])), "wb") as out:
        writer = csv.writer(out)
        writer.writerow(header)
        for x in annots:
            writer.writerow([x.tier, x.word, x.utt_type, x.present, x.speaker,  x.timestamp(), x.pho_annot.split("_")[0], ""])


for root, dirs, files in os.walk(input_dir):
    for file in files:
        if file.endswith(".cha"):
            print file
            try:
                cf = pc.ClanFile(os.path.join(root, file))
                cf.annotate()
                cf.assign_pho()
                annots = [x for x in cf.annotations() if x.speaker == "CHI"]
                if annots:
                    output_bl(file, annots)
            except Exception as e:
                print e.__repr__()