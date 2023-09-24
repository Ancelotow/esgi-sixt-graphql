import TownRepository from "../repositories/townRepository";
import Town from "../entities/town";

class TownController {

    private _repository: TownRepository;

    getAll(): Promise<Town[]> {
        return this._repository.getAll();
    }

    async getByCode(code: string): Promise<Town> {
        let towns = await this._repository.getAll()
        return towns.filter(town => town.insee_code === code)[0];
    }

}

export default new TownController();
