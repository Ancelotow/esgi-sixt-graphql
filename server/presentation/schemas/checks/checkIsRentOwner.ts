import invalidError from "../errors/invalidError";
import RentController from "../../../domain/controllers/rentController";

const checkIsRentOwner = async (rentId: number, userId: number) => {
    let rent = await RentController.getById(rentId);
    if (rent.userId !== userId) {
        throw invalidError("You are not owner of this rent", 'NOT_RENT_OWNER');
    }
}

export default checkIsRentOwner;
