import ModelRepository from "../repositories/modelRepository";
import Model from "../entities/model";
import ModelDbRepository from "../../data/repositories/database/modelDbRepository";

class ModelController {

    private _repository: ModelRepository = new ModelDbRepository();

    getAll(): Promise<Model[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Model> {
        let models = await this._repository.getAll()
        return models.filter(model => model.id === id)[0];
    }

}

export default new ModelController();
