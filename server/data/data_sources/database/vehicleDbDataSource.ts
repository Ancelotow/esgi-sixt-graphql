import VehicleDao from "../../models/dao/vehicleDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";
import AddVehicleDto from "../../models/dto/addVehicleDto";

class VehicleDbDataSource {

    async get(): Promise<Array<VehicleDao>> {
        const query = new Query('SELECT id, number_plate, nb_places, kilometrage, is_air_conditioner, amount_excluding, max_charge, max_speed_allowed, model_id, color_id, center_id, transmission_id FROM vehicle');
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new VehicleDao(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11])
        );
    }

    async vehicleFilter(
        maximumKilometrage: number|null,
        minimumPlaces: number|null,
        //is_air_conditioner: boolean|null,
        //max_charge: number|null,
        //max_speed_allowed: number|null,
        //model_id: number|null,
        //color_id: number|null,
        //center_id: number|null,
        //transmission_id: number|null
    ): Promise<Array<VehicleDao>> {
        if(maximumKilometrage == null) return this.get()
        
        const query = new Query(
            'SELECT id, number_plate, nb_places, kilometrage, is_air_conditioner, amount_excluding, max_charge, max_speed_allowed, model_id, color_id, center_id, transmission_id FROM vehicle WHERE kilometrage < $1 AND nb_places >= $2', 
            [maximumKilometrage??10000000, minimumPlaces??1]
        );
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new VehicleDao(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11])
        );
    }

    async updateVehicle(vehicleId: number, kilometrage: number): Promise<VehicleDao> {
        const query = new Query(
            'UPDATE "vehicle" SET kilometrage = $1 WHERE id = $2 RETURNING id, number_plate, nb_places, kilometrage, is_air_conditioner, amount_excluding, max_charge, max_speed_allowed, model_id, color_id, center_id, transmission_id',
            [kilometrage,vehicleId]
        );
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new VehicleDao(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11])
            //(row: any) => new VehicleDao(row[0].id, row[0].number_plate, row[0].nb_places, row[0].kilometrage, row[0].is_air_conditioner,row[0].amount_excluding,row[0].max_charge,row[0].max_speed_allowed,row[0].model_id,row[0].color_id,row[0].center_id,row[0].transmission_id)
        )[0];
    }

    async addVehicle(vehicleInput: AddVehicleDto): Promise<VehicleDao> {
        const query = new Query(
            'INSERT INTO "vehicle" (number_plate, nb_places, kilometrage, is_air_conditioner, amount_excluding, max_charge, max_speed_allowed, model_id, color_id, center_id, transmission_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING id',
            [vehicleInput.number_plate, vehicleInput.nb_places,vehicleInput.kilometrage,vehicleInput.is_air_conditioner,vehicleInput.amount_excluding,vehicleInput.max_charge,vehicleInput.max_speed_allowed,vehicleInput.model_id,vehicleInput.color_id,vehicleInput.center_id,vehicleInput.transmission_id]
        );
        const result = await dbService.dbClient.execute(query);
        console.log('Add vehicle result : ', result);
        return result.rows.map(
            (row: any) => new VehicleDao(row[0], vehicleInput.number_plate, vehicleInput.nb_places,vehicleInput.kilometrage,vehicleInput.is_air_conditioner,vehicleInput.amount_excluding,vehicleInput.max_charge,vehicleInput.max_speed_allowed,vehicleInput.model_id,vehicleInput.color_id,vehicleInput.center_id,vehicleInput.transmission_id)
        )[0];
    }

}

export default VehicleDbDataSource
