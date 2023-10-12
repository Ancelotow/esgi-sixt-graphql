import CenterRepository from "../../../domain/repositories/centerRepository";
import CenterDbDataSource from "../../data_sources/database/centerDbDataSource";
import Center from "../../../domain/entities/center";
import AddCenterDto from "../../models/dto/addCenterDto";

class CenterDbRepository implements CenterRepository {

    private _dataSource: CenterDbDataSource = new CenterDbDataSource();

    async getAll(): Promise<Center[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

    async add(center: AddCenterDto): Promise<Center> {
        let results = await this._dataSource.add(center);
        return results.toEntity();
    }

    async delete(centerId: number): Promise<Center> {
        let results = await this._dataSource.delete(centerId);
        return results.toEntity();
    }

}

export default CenterDbRepository
