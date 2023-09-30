import VehicleDao from "../../models/vehicleDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";

class VehicleDbDataSource {

    async get(): Promise<Array<VehicleDao>> {
        const query = new Query('SELECT id, number_plate, nb_places, kilometrage, is_air_conditioner, amount_excluding, max_charge, max_speed_allowed, model_id, color_id, center_id, transmission_id FROM vehicle')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new VehicleDao(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11])
        );
    }

}

export default VehicleDbDataSource
