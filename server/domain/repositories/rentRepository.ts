import Rent from "../entities/rent";

interface RentRepository {
    getAll(): Promise<Rent[]>;
    updateRentStatus(rentId: number, statusId: number): Promise<Rent>
}

export default RentRepository;
