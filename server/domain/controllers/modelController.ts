import ModelRepository from "../repositories/modelRepository";
import Model from "../entities/model";

class ModelController {

    private _repository: ModelRepository;

    getAll(): Promise<Model[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Model> {
        let models = await this._repository.getAll()
        return models.filter(model => model.id === id)[0];
    }

}

export default new ModelController();
