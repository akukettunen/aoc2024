const fs = require('fs');

const solve = fileName => {
  const dataBuffer = fs.readFileSync(fileName);
  const data = dataBuffer.toString();
  const rows = data.split("\n");

  let validRows = 0;
  rows.forEach(row => {
    const vals = row.split(" ").map(val => parseInt(val))

    for(let i = -1; i < vals.length; i++) {
      if(checkIfRowValid(vals, i)) {
        validRows++;
        break;
      }
    }
  })

  return validRows
}

const checkIfRowValid = (vals, ignore_index) => {
  // This i hate - splice mutates the original array
  new_vals = [...vals]
  ignore_index >= 0 && new_vals.splice(ignore_index, 1)

  let valid = true;
  let ascending = vals[0] < vals[vals.length - 1];
  let i = 1;

  while(valid && i < vals.length) {
    prev = new_vals[i - 1]
    if(
      (ascending && new_vals[i] < prev)
      || (!ascending && new_vals[i] > prev)
      || Math.abs(new_vals[i] - prev) > 3
      || new_vals[i] === prev
    ) valid = false;

    i++;
  }

  return valid
};

const start = Date.now();
const answer = solve('input.txt');
const end = Date.now();

console.log(`Running took ${end - start}ms`);
console.log(`and the answer is ${answer}`);