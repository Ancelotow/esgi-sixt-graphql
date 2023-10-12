import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLBoolean, GraphQLInt, GraphQLNonNull, GraphQLString} from "graphql";
import VehicleController from "../../../domain/controllers/vehicleController";
import AddVehicleDto from "../../../data/models/dto/addVehicleDto";
import vehicleInterface from "../interfaces/Vehicle";
import checkIsAdmin from "../checks/checkIsAdmin";


const addVehicleType = mutationWithClientMutationId({
    name: 'AddVehicle',
    inputFields: {
        numberPlate: { type: GraphQLNonNull(GraphQLString) },
        nbPlaces: { type: GraphQLNonNull(GraphQLInt) },
        kilometrage: { type: GraphQLNonNull(GraphQLInt) },
        isAirConditioner: { type: GraphQLNonNull(GraphQLBoolean) },
        amountExcluding: { type: GraphQLNonNull(GraphQLInt) },
        maxCharge: { type: GraphQLNonNull(GraphQLInt) },
        maxSpeedAllowed: { type: GraphQLNonNull(GraphQLInt) },
        modelId: { type: GraphQLNonNull(GraphQLInt) },
        colorId: { type: GraphQLNonNull(GraphQLInt) },
        centerId: { type: GraphQLNonNull(GraphQLInt) },
        transmissionId: { type: GraphQLNonNull(GraphQLInt) },
        imageUri: { type: GraphQLNonNull(GraphQLString) },
    },
    outputFields: {
        vehicle: {type: vehicleInterface},
    },
    mutateAndGetPayload: async (input, context) => {
        checkIsAdmin(context); // Throw error if user is not admin

        let vehicleDto = new AddVehicleDto();
        vehicleDto.number_plate = input.numberPlate;
        vehicleDto.nb_places = input.nbPlaces;
        vehicleDto.kilometrage = input.kilometrage;
        vehicleDto.is_air_conditioner = input.isAirConditioner;
        vehicleDto.amount_excluding = input.amountExcluding;
        vehicleDto.max_charge = input.maxCharge;
        vehicleDto.max_speed_allowed = input.maxSpeedAllowed;
        vehicleDto.model_id = input.modelId;
        vehicleDto.color_id = input.colorId;
        vehicleDto.center_id = input.centerId;
        vehicleDto.transmission_id = input.transmissionId;
        vehicleDto.image_uri = input.imageUri;
        let vehicleAdded = await VehicleController.addVehicle(vehicleDto);
        return {vehicle: vehicleAdded};
    },
})

export {addVehicleType}
