def solve(file_name):
  file = open(file_name, "r")
  lines = file.readlines()
  count = 0

  for (i, line) in enumerate(lines):
    line = line.strip()

    for (j, char) in enumerate(line):
      vert = ""
      diag_down = ""
      diag_up = ""
      hor = ""

      if(i <= len(lines) - 4):
        vert = char + lines[i+1][j] + lines[i+2][j] + lines[i+3][j]

      if(j <= len(line) - 4):
        hor = line[j:j+4]

      if(i <= len(lines) - 4 and j <= len(line) - 4):
        diag_down = char + lines[i+1][j+1] + lines[i+2][j+2] + lines[i+3][j+3]

      if(i >= 3 and j <= len(line) - 4):
        diag_up = char + lines[i-1][j+1] + lines[i-2][j+2] + lines[i-3][j+3]

      for t in [hor, vert, diag_up, diag_down]:
        if(t in ["XMAS", "SAMX"]):
          count = count + 1

  return count

ans = solve("input.txt")
print("Part 1 answer is: ", ans)