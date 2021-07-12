import knex from 'knex'

const config = {
    client: 'mysql',
    connection: {
        host : 'ns1-442.axc.nl',
        user : process.env.dbuser,
        password : process.env.dbpassword,
        database : process.env.dbname
    },
  };
  
const knexInstance = knex(config);

export const sql = knexInstance;