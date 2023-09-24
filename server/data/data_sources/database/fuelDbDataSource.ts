import FuelDao from "../../models/fuelDao";
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

}

export default FuelDbDataSource
