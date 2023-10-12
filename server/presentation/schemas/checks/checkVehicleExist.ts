import VehicleController from "../../../domain/controllers/vehicleController";
import invalidError from "../errors/invalidError";

const checkVehicleExist = async (vehicleId: number) => {
    let isVehicleExist = await VehicleController.getById(vehicleId);
    if (!isVehicleExist) {
        throw invalidError("Vehicle does not exist", 'VEHICLE_DOES_NOT_EXIST');
    }
}

export default checkVehicleExist;
