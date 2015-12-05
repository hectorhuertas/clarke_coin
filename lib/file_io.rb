class FileIO
  def read(file)
    File.read(file)
  end

  def write(file, content)
    File.write(file, content)
  end
end
