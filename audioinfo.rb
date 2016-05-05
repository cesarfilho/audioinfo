
require "mp3info"
require 'os'

#Parametro do diretório a ser formatado
folder_path = ARGV[0]

def CleanPathMusic(path)

  if OS.windows?
    path = path.gsub(/\\/, '/')
  end

  Dir.glob(path + '/*').sort.each do |file|
      if File.directory? file
        CleanPathMusic(file)
      elsif
        CleanFileName(file)
        lTags = ['artist','title']
        ShowMp3Tags(file,lTags)
      end
  end
end

def CleanFileName(file)
  filename = File.basename(file, File.extname(file))
  filename = filename.gsub(/_/, '').gsub(/-/, ' - ')
  filename = filename.split.map(&:capitalize).join(' ')
  return filename
end

def ShowMp3Tags(file,lTags)
  if File.extname(file).upcase == '.MP3'
    Mp3Info.open(file) do |mp3|
      lTags.each do |tags|
        puts mp3.tag.tags
      end
    end
  end
end

CleanPathMusic(folder_path)
