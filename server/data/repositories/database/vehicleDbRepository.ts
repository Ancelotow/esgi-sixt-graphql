import VehicleRepository from "../../../domain/repositories/vehicleRepository";
import VehicleDbDataSource from "../../data_sources/database/vehicleDbDataSource";
import Vehicle from "../../../domain/entities/vehicle";

class VehicleDbRepository implements VehicleRepository {

    private _dataSource: VehicleDbDataSource = new VehicleDbDataSource();

    async getAll(): Promise<Vehicle[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

    async getAllFiltered(maximumKilometrage: number|null, minimumPlaces: number|null): Promise<Vehicle[]> {
        let results = await this._dataSource.vehicleFilter(maximumKilometrage, minimumPlaces);
        return results.map(e => e.toEntity());
    }

    async updateVehicle(id: number, kilometrage: number): Promise<Vehicle> {
        let results = await this._dataSource.updateVehicle(id, kilometrage);
        return results.toEntity();
    }

}

export default VehicleDbRepository
