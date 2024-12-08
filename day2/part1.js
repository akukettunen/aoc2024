const fs = require('fs');

const solve = fileName => {
  const dataBuffer = fs.readFileSync(fileName);
  const data = dataBuffer.toString();
  const rows = data.split("\n");

  let validRows = 0;
  rows.forEach(row => {
    checkIfRowValid(row) && validRows++;
  })

  return validRows
}

const checkIfRowValid = row => {
  const vals = row.split(" ").map(val => parseInt(val))

  let valid = true;
  let ascending = vals[0] < vals[vals.length - 1];
  let i = 1;

  while(valid && i < vals.length) {
    prev = vals[i - 1]
    if(ascending && vals[i] < prev) valid = false;
    else if(!ascending && vals[i] > prev) valid = false;
    else if(Math.abs(vals[i] - prev) > 3 || vals[i] === prev) valid = false;
    i++;
  }

  return valid
};

const start = Date.now();
const answer = solve('input.txt');
const end = Date.now();

console.log(`Running took ${end - start}ms`);
console.log(`and the answer is ${answer}`);