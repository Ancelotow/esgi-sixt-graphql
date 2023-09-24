import Rent from "../entities/rent";

interface RentRepository {
    getAll(): Promise<Rent[]>;
}

export default RentRepository;
