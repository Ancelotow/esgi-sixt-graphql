import BrandDao from "../../models/dao/brandDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";
import CenterDao from "../../models/dao/centerDao";

class CenterDbDataSource {

    async get(): Promise<Array<CenterDao>> {
        const query = new Query('SELECT id, name, address, insee_code FROM center')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new CenterDao(row[0], row[1], row[2], row[3])
        );
    }

}

export default CenterDbDataSource
