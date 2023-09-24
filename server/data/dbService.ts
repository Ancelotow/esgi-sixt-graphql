import {Client} from 'ts-postgres';
import {config} from 'dotenv'

config()

class DbService {

    public dbClient = new Client({
        user: process.env.PG_USER,
        host: process.env.PG_HOST,
        database: process.env.PG_DBNAME,
        password: process.env.PG_PASSWORD,
        port: parseInt(process.env.PG_PORT)
    });

}

export default new DbService();
