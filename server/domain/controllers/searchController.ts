import VehicleRepository from "../repositories/vehicleRepository";
import Vehicle from "../entities/vehicle";
import VehicleDbRepository from "../../data/repositories/database/vehicleDbRepository";
import ModelDbRepository from "../../data/repositories/database/modelDbRepository";
import Model from "../entities/model";

class SearchController {

    private _vehicleRepository: VehicleRepository = new VehicleDbRepository();
    private _modelRepository: ModelDbRepository = new ModelDbRepository();
    private vehicles: Vehicle[] = [];
    private models: Model[] = [];

    /**
     * Research by model, vehicleType,
     * @param prompt
     * @returns 
     */
    async filter(prompt: string): Promise<Vehicle[]> {
        if (this.vehicles.length == 0) {
            this.vehicles = await this._vehicleRepository.getAll();
        }
        if (this.models.length == 0) {
            this.models = await this._modelRepository.getAll();
        }

        let modelFiltered = this.models.filter( model => model.name.toLowerCase().includes(prompt.toLowerCase())).map( model => model.id);
        console.log(modelFiltered.length);
        if (modelFiltered.length == 0) { modelFiltered = null }

        return this.vehicles.filter(vehicle => 
            (modelFiltered?.includes(vehicle.modelId) ?? true) //||
            //this.isOfType(prompt, vehicle)
        );
    }

    private isOfType(query: string, obj: Vehicle): boolean {
        if (query.toLowerCase().includes('limousine')) {
            return obj.length != null;
        }
        if (query.toLowerCase().includes('van')) {
            return (obj.maxCharge != null);
        }
        if (query.toLowerCase().includes('sportcar')) {
            return (obj.power != null);
        }
        return true
    }

}

export default new SearchController();
