import VehicleDao from "../../models/vehicleDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";

class VehicleDbDataSource {

    async get(): Promise<Array<VehicleDao>> {
        const query = new Query('SELECT id, number_plate, nb_places, kilometrage, is_air_conditioner, amount_excluding, max_charge, max_speed_allowed, model_id, color_id, center_id FROM vehicle')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new VehicleDao(row.id, row.number_plate, row.nb_places, row.kilometrage, row.is_air_conditioner, row.amount_excluding, row.max_charge, row.max_speed_allowed, row.model_id, row.color_id, row.center_id)
        );
    }

}

export default VehicleDbDataSource
