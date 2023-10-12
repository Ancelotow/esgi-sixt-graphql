import AddCenterDto from "../../data/models/dto/addCenterDto";
import UpdateCenterDto from "../../data/models/dto/updateCenterDto";
import Center from "../entities/center";

interface CenterRepository {
    getAll(): Promise<Center[]>;
    add(center: AddCenterDto): Promise<Center>;
    delete(centerId: number): Promise<Center>;
    update(centerId: number, data: UpdateCenterDto): Promise<Center>;
}

export default CenterRepository;
