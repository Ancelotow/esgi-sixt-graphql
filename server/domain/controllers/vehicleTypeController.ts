import VehicleTypeRepository from "../repositories/vehicleTypeRepository";
import VehicleType from "../entities/vehicleType";

class VehicleTypeController {

    private _repository: VehicleTypeRepository;

    getAll(): Promise<VehicleType[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<VehicleType> {
        let vehicleTypes = await this._repository.getAll()
        return vehicleTypes.filter(vehicleType => vehicleType.id === id)[0];
    }

}

export default new VehicleTypeController();
