import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLError, GraphQLInt, GraphQLNonNull, GraphQLString} from "graphql";
import VehicleController from "../../../domain/controllers/vehicleController";
import vehicleInterface from "../interfaces/Vehicle";


const updateVehicleType = mutationWithClientMutationId({
    name: 'UpdateVehicle',
    inputFields: {
        vehicleId: { type: GraphQLNonNull(GraphQLInt) },
        kilometrage: { type: GraphQLNonNull(GraphQLInt) }
    },
    outputFields: {
        vehicle: {type: vehicleInterface},
    },
    mutateAndGetPayload: async (input) => {
        let isVehicleExist = await VehicleController.getById(input.vehicleId);
        if (!isVehicleExist) {
            throw new GraphQLError('User already exists',
                null,
                null,
                null,
                null,
                null,
                { code: 'EMAIL_EXIST', date: Date.now(), status: 400}
            );
        } 
        let vehicleUpdated = await VehicleController.updateVehicle(input.vehicleId, input.kilometrage);
        return {vehicle: vehicleUpdated};
    },
})

export {updateVehicleType}
