import RentRepository from "../../../domain/repositories/rentRepository";
import Rent from "../../../domain/entities/rent";
import RentDbDataSource from "../../data_sources/database/rentDbDataSource";

class RentDbRepository implements RentRepository{

    private _dataSource = new RentDbDataSource();

    async getAll(): Promise<Rent[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default RentDbRepository;
