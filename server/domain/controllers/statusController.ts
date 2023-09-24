import StatusRepository from "../repositories/statusRepository";
import Status from "../entities/status";

class StatusController {

    private _repository: StatusRepository;

    getAll(): Promise<Status[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Status> {
        let status = await this._repository.getAll()
        return status.filter(st => st.id === id)[0];
    }

}

export default new StatusController();
