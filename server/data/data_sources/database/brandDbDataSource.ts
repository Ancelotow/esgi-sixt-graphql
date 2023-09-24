import BrandDao from "../../models/brandDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";

class BrandDbDataSource {

    async get(): Promise<BrandDao[]> {
        const query = new Query('SELECT id, name, logo_uri FROM brand')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new BrandDao(row[0], row[1], row[2])
        );
    }

}

export default BrandDbDataSource
