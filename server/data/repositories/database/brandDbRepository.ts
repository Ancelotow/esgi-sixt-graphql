import BrandRepository from "../../../domain/repositories/brandRepository";
import Brand from "../../../domain/entities/brand";
import BrandDbDataSource from "../../data_sources/database/brandDbDataSource";

class BrandDbRepository implements BrandRepository {

    private _dataSource: BrandDbDataSource = new BrandDbDataSource();

    async getAll(): Promise<Brand[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default BrandDbRepository
