import Model from "../entities/model";

interface ModelRepository {
    getAll(): Promise<Model[]>;
}

export default ModelRepository;
