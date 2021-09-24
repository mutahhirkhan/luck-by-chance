
const path = require("path"); //use path so it work fine in unix or windows
const fs = require("fs");
const solc = require("solc");

const lotteryPath = path.resolve(__dirname, "Contracts", "lottery.sol");
const source = fs.readFileSync(lotteryPath, "utf-8");



module.exports =  solc.compile(source, 1).contracts[':lottery']; //contract name, number of contract to deploy