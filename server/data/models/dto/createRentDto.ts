class CreateRentDto {
    nb_days: number
    amount_excluding: number
    vat_rate: number
    rent_at: Date
    created_at: Date
    vehicle_id: number
    user_id: number
    status_id: number
}

export default CreateRentDto