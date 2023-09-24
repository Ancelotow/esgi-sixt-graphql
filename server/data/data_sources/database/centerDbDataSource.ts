import BrandDao from "../../models/brandDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";
import CenterDao from "../../models/centerDao";

class CenterDbDataSource {

    async get(): Promise<Array<CenterDao>> {
        const query = new Query('SELECT id, name, address, insee_code FROM center')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new CenterDao(row.id, row.name, row.address, row.insee_code)
        );
    }

}

export default CenterDbDataSource
