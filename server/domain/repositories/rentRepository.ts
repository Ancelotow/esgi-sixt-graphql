import CreateRentDto from "../../data/models/dto/createRentDto";
import Rent from "../entities/rent";

interface RentRepository {
    getAll(): Promise<Rent[]>;
    updateRentStatus(rentId: number, statusId: number): Promise<Rent>;
    createRent(rent: CreateRentDto): Promise<Rent>;
}

export default RentRepository;
