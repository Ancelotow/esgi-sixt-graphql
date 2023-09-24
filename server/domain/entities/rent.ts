class Rent {
    id: number
    nbDays: number
    amountExcluding: number
    vatRate: number
    rentAt: Date
    createdAt: Date
    vehicleId: number
    userId: number
    statusId: number

    isFinished(): boolean {
        return this.statusId === 4 || this.statusId === 5
    }
}

export default Rent
