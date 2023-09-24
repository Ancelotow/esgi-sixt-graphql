import VehicleRepository from "../repositories/vehicleRepository";
import Vehicle from "../entities/vehicle";
import VehicleDbRepository from "../../data/repositories/database/vehicleDbRepository";

class VehicleController {

    private _repository: VehicleRepository = new VehicleDbRepository();

    getAll(): Promise<Vehicle[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Vehicle> {
        let vehicles = await this._repository.getAll()
        return vehicles.filter(vehicle => vehicle.id === id)[0];
    }

}

export default new VehicleController();
