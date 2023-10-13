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

        let modelFiltered = this.models.filter( model => prompt.toLowerCase().includes(model.name.toLowerCase())).map( model => model.id);
        console.log(modelFiltered.length);
        if (modelFiltered.length == 0) { modelFiltered = null }

        if (modelFiltered != null && this.isQueryType(prompt)) {
            return this.vehicles.filter(vehicle => 
                modelFiltered.includes(vehicle.modelId) &&
                this.isOfType(prompt, vehicle)
            );
        }
        if (modelFiltered != null && !this.isQueryType(prompt)) {
            return this.vehicles.filter(vehicle => 
                modelFiltered.includes(vehicle.modelId)
            );
        }

        if (modelFiltered == null && this.isQueryType(prompt)) {
            return this.vehicles.filter(vehicle => 
                this.isOfType(prompt, vehicle)
            );
        }

        return this.vehicles
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
        return (query.toLowerCase().includes('sedan'))
    }

    private isQueryType(query: string): boolean {
        return (query.toLowerCase().includes('limousine') || query.toLowerCase().includes('van') || query.toLowerCase().includes('sportcar') || query.toLowerCase().includes('sedan'));
    }

}

export default new SearchController();
