import AddCenterDto from "../../data/models/dto/addCenterDto";
import Center from "../entities/center";

interface CenterRepository {
    getAll(): Promise<Center[]>;
    add(center: AddCenterDto): Promise<Center>;
    delete(centerId: number): Promise<Center>;
}

export default CenterRepository;
