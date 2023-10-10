import {Query} from "ts-postgres";
import dbService from "../../dbService";
import RentDao from "../../models/dao/rentDao";

class RentDbDataSource {

    async get(): Promise<Array<RentDao>> {
        const query = new Query('SELECT id, nb_days, amount_excluding, vat_rate, rent_at, created_at, vehicle_id, user_id, status_id FROM rent')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new RentDao(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
        );
    }

}

export default RentDbDataSource
