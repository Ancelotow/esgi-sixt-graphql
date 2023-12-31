class AddVehicleDto {
    number_plate: string
    nb_places: number
    kilometrage: number
    is_air_conditioner: boolean
    amount_excluding: number
    max_charge: number
    max_speed_allowed: number
    model_id: number
    color_id: number
    center_id: number
    transmission_id: number
    image_uri: string
    capacity: number // For Van
    height: number // For Van
    length: number // For Limousine
    power: number // For SportCar
}

export default AddVehicleDto

