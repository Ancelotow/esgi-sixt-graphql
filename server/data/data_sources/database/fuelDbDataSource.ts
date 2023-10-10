import FuelDao from "../../models/dao/fuelDao";
import dbService from "../../dbService";
import {Query} from "ts-postgres";

class FuelDbDataSource {

    async get(): Promise<Array<FuelDao>> {
        const query = new Query('SELECT id, name FROM fuel')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new FuelDao(row[0], row[1])
        );
    }

    async getByModel(idModel: number): Promise<Array<FuelDao>> {
        const query = new Query(
            'SELECT f.id, f.name FROM fuel f JOIN model_fuel m ON f.id = m.id_fuel AND m.id_model = $1',
            [idModel]
        )
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new FuelDao(row[0], row[1])
        );
    }

}

export default FuelDbDataSource
