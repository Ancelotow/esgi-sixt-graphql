import RentRepository from "../repositories/rentRepository";
import Rent from "../entities/rent";
import RentDbRepository from "../../data/repositories/database/rentDbRepository";
import CreateRentDto from "../../data/models/dto/createRentDto";

class RentController {

    private _repository: RentRepository = new RentDbRepository();

    getAll(): Promise<Rent[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Rent> {
        let results = await this._repository.getAll();
        return results.find((rent) => rent.id === id);
    }

    async updateRentStatus(rentId: number, statusId: number): Promise<Rent> {
        return await this._repository.updateRentStatus(rentId,statusId);
    }

    async createRent(rent: CreateRentDto): Promise<Rent> {
        return await this._repository.createRent(rent);
    }

}

export default new RentController();
