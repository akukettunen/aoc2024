def solve(file_name):
  file = open(file_name, "r")
  lines = file.readlines()
  lines_len = len(lines)
  count = 0

  for (i, line) in enumerate(lines):
    line = line.strip()
    line_len = len(line)

    for (j, char) in enumerate(line):
      if char == "A" and i >= 1 and j >= 1 and i <= lines_len - 2 and j <= line_len - 2:
        a = lines[i-1][j-1] # Top left
        b = lines[i-1][j+1] # Top right
        c = lines[i+1][j+1] # Bottom right
        d = lines[i+1][j-1] # Bottom left

        if( a+b+c+d in ["SSMM", "SMMS", "MMSS", "MSSM"] ):
          count = count + 1

  return count

ans = solve("input.txt")
print("Part 2 answer is: ", ans)