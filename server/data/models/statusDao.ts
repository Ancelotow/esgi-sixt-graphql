import Status from "../../domain/entities/status";

class StatusDao {
    constructor(
        public id: number,
        public name: string
    ) {}

    toEntity() {
        let status = new Status()
        status.id = this.id
        status.name = this.name
        return status
    }
}

export default StatusDao
