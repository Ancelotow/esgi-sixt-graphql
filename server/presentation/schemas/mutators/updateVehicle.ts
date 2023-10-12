import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLInt, GraphQLNonNull} from "graphql";
import VehicleController from "../../../domain/controllers/vehicleController";
import vehicleInterface from "../interfaces/Vehicle";
import checkIsAdmin from "../checks/checkIsAdmin";
import checkVehicleExist from "../checks/checkVehicleExist";
import checkIsAuthenticated from "../checks/checkIsAuthenticated";


const updateVehicleType = mutationWithClientMutationId({
    name: 'UpdateVehicle',
    inputFields: {
        vehicleId: { type: GraphQLNonNull(GraphQLInt) },
        kilometrage: { type: GraphQLNonNull(GraphQLInt) }
    },
    outputFields: {
        vehicle: {type: vehicleInterface},
    },
    mutateAndGetPayload: async (input, context) => {
        checkIsAuthenticated(context); // Throw error if user is not authenticated
        await checkVehicleExist(input.vehicleId); // Throw error if vehicle does not exist

        let vehicleUpdated = await VehicleController.updateVehicle(input.vehicleId, input.kilometrage);
        return {vehicle: vehicleUpdated};
    },
})

export {updateVehicleType}
