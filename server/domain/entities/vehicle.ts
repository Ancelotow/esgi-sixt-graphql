class Vehicle {
    id: number
    numberPlate: string
    nbPlaces: number
    kilometrage: number
    isAirConditioner: boolean
    amountExcluding: number // Montant HT
    maxCharge: number
    maxSpeedAllowed: number
    modelId: number
    colorId: number
    centerId: number
    transmissionId: number
    imageUri: string
    capacity: number // For Van
    height: number // For Van
    length: number // For Limousine
    power: number // For SportCar
    isDelete: boolean
}

export default Vehicle
