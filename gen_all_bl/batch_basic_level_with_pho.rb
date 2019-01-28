require 'Datavyu_API'

$input_dir = "~/code/work/seedlings/datavyu_scripts/data/all_opf"
$output_dir = "~/code/work/seedlings/datavyu_scripts/data/all_bl_out"

def match(annot, other)
    if other.object.to_s.start_with?("%pho") and\
         other.onset.to_s == annot.offset.to_s and\
         other.offset.to_s == annot.offset.to_s
         return true
    end
    return false
end

def basic_level(in_dir, file)
  puts(file)
  $db, $pj = load_db(File.join(in_dir, file))
  columns = get_column_list()
  for column in columns
    bl_out_path = File.join(File.expand_path($output_dir), file.sub(".opf", "_phos_processed.csv"))
    col = getColumn(column)
    if col.cells.length == 0
      next
    end


    CSV.open(bl_out_path, "wb") do |csv|
      csv << ["labeled_object.ordinal","labeled_object.onset",
              "labeled_object.offset","labeled_object.object",
              "labeled_object.utterance_type","labeled_object.object_present",
              "labeled_object.speaker", "labeled_object.pho", "labeled_object.basic_level"]
    
    i = 1
    for cell in col.cells
        if cell.speaker == "CHI"
            found = nil
            for x in col.cells
                if match(cell, x)
                    if found != nil 
                        puts("more than 1 match:  #{cell.object} - #{i}")
                        # exit
                    end
                    found = x
                end
            end
            if found == nil 
                puts("didn't find a pho for this: #{cell.object} - #{i}")
            else
                csv << [cell.ordinal.to_s, cell.onset.to_s, cell.offset.to_s, cell.object.to_s,
                        cell.utterance_type.to_s, cell.object_present.to_s, cell.speaker.to_s,
                        found.object.to_s.gsub("%pho:", ""), ""]
            end
        end
        i += 1
    end
    
end
end
end




begin
  in_dir = File.expand_path($input_dir)
  filenames = Dir.new(in_dir).entries

  for file in filenames
    if file.end_with? ".opf"
      basic_level(in_dir, file)
    end
  end
end
