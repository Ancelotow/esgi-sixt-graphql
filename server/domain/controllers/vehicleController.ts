import VehicleRepository from "../repositories/vehicleRepository";
import Vehicle from "../entities/vehicle";
import VehicleDbRepository from "../../data/repositories/database/vehicleDbRepository";
import RentRepository from "../repositories/rentRepository";
import Rent from "../entities/rent";
import RentDbRepository from "../../data/repositories/database/rentDbRepository";

class VehicleController {

    private _repository: VehicleRepository = new VehicleDbRepository();
    private _rentRepository: RentRepository = new RentDbRepository();

    getAll(): Promise<Vehicle[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Vehicle> {
        let vehicles = await this._repository.getAll()
        return vehicles.filter(vehicle => vehicle.id === id)[0];
    }

    async getVehicleLastRent(id: number): Promise<Rent> {
        let rents = await this._rentRepository.getAll();
        let vehicleRents = rents.filter(rent => rent.vehicleId === id);
        return vehicleRents.sort((a, b) => a.rentAt.getTime() - b.rentAt.getTime())[0];
    }

}

export default new VehicleController();
