import FuelRepository from "../repositories/fuelRepository";
import Fuel from "../entities/fuel";

class FuelController {

    private _repository: FuelRepository;

    getAll(): Promise<Fuel[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Fuel> {
        let fuels = await this._repository.getAll()
        return fuels.filter(fuel => fuel.id === id)[0];
    }

}

export default new FuelController();
