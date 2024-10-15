const fs = require('fs');
const path = require('path');

// Read the SQL file from your repository
const sqlFilePath = path.join(__dirname, 'src/ddl/editedCeds_cleaned_for_postgres.sql');
const sqlFileContent = fs.readFileSync(sqlFilePath, 'utf8');

// Regex to find all foreign key definitions prefixed with FK_
const foreignKeyRegex = /CONSTRAINT \"(.*?)\" FOREIGN KEY/g;
let match;
const foreignKeys = [];

// Find all foreign keys and push them into the array
while ((match = foreignKeyRegex.exec(sqlFileContent)) !== null) {
  foreignKeys.push(match[1]); // match[1] is the foreign key name
}

// console.log('Found Foreign Keys:', foreignKeys);

const MAX_LENGTH = 63; // PostgreSQL's max identifier length

const countMaxLengthForeignKeys = foreignKeys.map(fk => {
  if (fk.length > MAX_LENGTH) {
    console.log(`Foreign Key "${fk}" exceeds ${MAX_LENGTH} chars"`);

    console.log(`Please review '${outputFile}' as these exceed postgres fKey maximum length constraints. Without adding additional transformations, the file will not be able to be applied. This is essential, if any fKeys exist that exceed maxLength will result in a migration error and prevent completing any database reset from migrations via Supabase CLI.`);
        
  }
  return null; // Foreign key is fine
}).filter(fk => fk !== null); // Filter out keys that don't need renaming

// console.log('Foreign Keys that exceed max length:', countMaxLengthForeignKeys);