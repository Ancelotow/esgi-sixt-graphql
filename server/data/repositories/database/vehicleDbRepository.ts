import VehicleRepository from "../../../domain/repositories/vehicleRepository";
import VehicleDbDataSource from "../../data_sources/database/vehicleDbDataSource";
import Vehicle from "../../../domain/entities/vehicle";

class VehicleDbRepository implements VehicleRepository {

    private _dataSource: VehicleDbDataSource = new VehicleDbDataSource();

    async getAll(): Promise<Vehicle[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default VehicleDbRepository
