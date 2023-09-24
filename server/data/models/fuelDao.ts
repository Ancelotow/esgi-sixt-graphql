import Fuel from "../../domain/entities/fuel";

class FuelDao {
    constructor(
        public id: number,
        public name: string
    ) { }

    toEntity() {
        let fuel = new Fuel()
        fuel.id = this.id
        fuel.name = this.name
        return fuel
    }
}

export default FuelDao
