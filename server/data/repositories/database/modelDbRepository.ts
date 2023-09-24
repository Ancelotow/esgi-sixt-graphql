import ModelRepository from "../../../domain/repositories/modelRepository";
import ModelDbDataSource from "../../data_sources/database/modelDbDataSource";
import Model from "../../../domain/entities/model";

class ModelDbRepository implements ModelRepository {

    private _dataSource: ModelDbDataSource = new ModelDbDataSource();

    async getAll(): Promise<Model[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default ModelDbRepository
