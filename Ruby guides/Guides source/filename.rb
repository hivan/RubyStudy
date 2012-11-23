def first_line(filename)
  begin
    file = open("some_file")
    info = file.gets
    file.close
    info
  rescue
    nil
  end
end
