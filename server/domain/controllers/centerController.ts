import CenterRepository from "../repositories/centerRepository";
import Center from "../entities/center";

class CenterController {

    private _repository: CenterRepository;

    getAll(): Promise<Center[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Center> {
        let centers = await this._repository.getAll()
        return centers.filter(center => center.id === id)[0];
    }

}

export default new CenterController();
