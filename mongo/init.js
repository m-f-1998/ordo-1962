// This script runs automatically in mongosh at container init time
const fs = require('fs');

const basePath = '/mongo';

function importFile(file) {
  const fullPath = basePath + '/' + file;
  const base = file.replace('.json', '');
  const parts = base.split('.');

  if (parts.length < 2) {
    print(`⚠️ Skipping ${file} — invalid format`);
    return;
  }

  const dbName = parts[0];
  const collectionName = parts[1];
  const jsonData = JSON.parse(fs.readFileSync(fullPath));

  db = db.getSiblingDB(dbName);
  db[collectionName].insertOne(jsonData);
}

fs.readdirSync(basePath)
  .filter(f => {
    return f.endsWith('.json')
  } )
  .forEach(x => {
    importFile(x);
  });

print("✅ All JSON files imported.");
