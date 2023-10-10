import ModelDao from "../../models/dao/modelDao";
import dbService from "../../dbService";
import {Query} from "ts-postgres";

class ModelDbDataSource {

    async get(): Promise<Array<ModelDao>> {
        const query = new Query('SELECT id, name, brand_id, type_id, release_year FROM model')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new ModelDao(row[0], row[1], row[2], row[3], row[4])
        );
    }

}

export default ModelDbDataSource
