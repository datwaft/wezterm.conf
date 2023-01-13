# use with https://github.com/casey/just

fennel-binary := 'fennel'
fennel-folder := 'fnl'

# Display list of commands
@help:
  just --list

# Remove compiled lua file
@clean:
  rm -f *.lua

# Compile every fennel file into lua files
@compile: clean
  for file in {{fennel-folder}}/*.fnl; do \
    {{fennel-binary}} \
      --add-fennel-path 'fnl/?.fnl' \
      --add-macro-path 'fnl/?.fnl' \
      --compile "$file" > "$(basename ${file} .fnl).lua"; \
  done
