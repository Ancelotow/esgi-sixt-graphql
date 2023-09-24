import BrandDao from "../../models/brandDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";

class BrandDbDataSource {

    async get(): Promise<Array<BrandDao>> {
        const query = new Query('SELECT id, name, logo_uri FROM brand')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new BrandDao(row.id, row.name, row.logo_uri)
        );
    }

}

export default BrandDbDataSource
