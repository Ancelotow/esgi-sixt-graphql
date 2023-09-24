import TownRepository from "../repositories/townRepository";
import Town from "../entities/town";
import TownDbRepository from "../../data/repositories/database/townDbRepository";

class TownController {

    private _repository: TownRepository = new TownDbRepository();

    getAll(): Promise<Town[]> {
        return this._repository.getAll();
    }

    async getByCode(code: string): Promise<Town> {
        let towns = await this._repository.getAll()
        return towns.filter(town => town.inseeCode === code)[0];
    }

}

export default new TownController();
