import Rent from "../../../domain/entities/rent";

class RentDao {
    constructor(
        public id: number,
        public nb_days: number,
        public amount_excluding: number,
        public vat_rate: number,
        public rent_at: Date,
        public created_at: Date,
        public vehicle_id: number,
        public user_id: number,
        public status_id: number,
    ) {}

    toEntity() {
        let rent = new Rent();
        rent.id = this.id;
        rent.nbDays = this.nb_days;
        rent.amountExcluding = this.amount_excluding;
        rent.vatRate = this.vat_rate;
        rent.rentAt = this.rent_at;
        rent.createdAt = this.created_at;
        rent.vehicleId = this.vehicle_id;
        rent.userId = this.user_id;
        rent.statusId = this.status_id;
        return rent;
    }
}

export default RentDao;
