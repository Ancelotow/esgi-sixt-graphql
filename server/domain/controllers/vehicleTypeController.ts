import VehicleTypeRepository from "../repositories/vehicleTypeRepository";
import VehicleType from "../entities/vehicleType";
import VehicleTypeDbRepository from "../../data/repositories/database/vehicleTypeDbRepository";

class VehicleTypeController {

    private _repository: VehicleTypeRepository = new VehicleTypeDbRepository();

    getAll(): Promise<VehicleType[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<VehicleType> {
        let vehicleTypes = await this._repository.getAll()
        return vehicleTypes.filter(vehicleType => vehicleType.id === id)[0];
    }

}

export default new VehicleTypeController();
