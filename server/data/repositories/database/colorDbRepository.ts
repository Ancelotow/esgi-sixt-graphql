import ColorRepository from "../../../domain/repositories/colorRepository";
import ColorDbDataSource from "../../data_sources/database/colorDbDataSource";
import Color from "../../../domain/entities/color";

class ColorDbRepository implements ColorRepository {

    private _dataSource: ColorDbDataSource = new ColorDbDataSource();

    async getAll(): Promise<Color[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default ColorDbRepository
