
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
        ShowMp3Tags(file)
        #puts CleanFileName(file)
      end
  end
end

def CleanFileName(file) 
  filename = File.basename(file, File.extname(file))
  filename = filename.gsub(/_/, '').gsub(/-/, ' - ')
  filename = filename.split.map(&:capitalize).join(' ')
  return filename
end

def ShowMp3Tags(file)
  if File.extname(file).upcase == '.MP3'

    Mp3Info.open(file) do |mp3|
        puts mp3.tag.title
        puts mp3.tag.artist
        #puts mp3.tag.album
        #puts mp3.tag.tracknum
    end
  end   
end 

CleanPathMusic(folder_path)
