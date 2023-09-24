import ModelDao from "../../models/modelDao";
import dbService from "../../dbService";
import {Query} from "ts-postgres";

class ModelDbDataSource {

    async get(): Promise<Array<ModelDao>> {
        const query = new Query('SELECT id, name, brand_id, type_id, release_year FROM model')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new ModelDao(row.id, row.name, row.brand_id, row.type_id, row.release_year)
        );
    }

}

export default ModelDbDataSource
