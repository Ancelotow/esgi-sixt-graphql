import Center from "../entities/center";

interface CenterRepository {
    getAll(): Promise<Center[]>;
}

export default CenterRepository;
