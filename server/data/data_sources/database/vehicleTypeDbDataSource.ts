import {Query} from "ts-postgres";
import dbService from "../../dbService";
import VehicleTypeDao from "../../models/vehicleTypeDao";

class VehicleTypeDbDataSource {

    async get(): Promise<Array<VehicleTypeDao>> {
        const query = new Query('SELECT id, name FROM vehicle_type')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new VehicleTypeDao(row.id, row.name)
        );
    }

}

export default VehicleTypeDbDataSource
