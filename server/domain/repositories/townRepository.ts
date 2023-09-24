import Town from "../entities/town";

interface TownRepository {
    getAll(): Promise<Town[]>;
}

export default TownRepository;
