import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLInt, GraphQLNonNull} from "graphql";
import RentController from "../../../domain/controllers/rentController";
import {rentType} from "../types/rentType";
import CreateRentDto from "../../../data/models/dto/createRentDto";
import { statusType } from "../types/statusType";
import checkVehicleExist from "../checks/checkVehicleExist";
import checkIsAdmin from "../checks/checkIsAdmin";
import checkIsAuthenticated from "../checks/checkIsAuthenticated";


const createRentType = mutationWithClientMutationId({
    name: 'CreateRent',
    inputFields: {
        nbDays: { type: GraphQLNonNull(GraphQLInt) },
        amountExcluding: { type: GraphQLNonNull(GraphQLInt) },
        vatRate: { type: GraphQLNonNull(GraphQLInt) },
        vehicleId: { type: GraphQLNonNull(GraphQLInt) },
        status: { type: GraphQLNonNull(statusType) },
    },
    outputFields: {
        rent: {type: rentType},
    },
    mutateAndGetPayload: async (input, context) => {
        checkIsAuthenticated(context); // Throw error if user is not authenticated
        await checkVehicleExist(input.vehicleId); // Throw error if vehicle does not exist

        let createRentObject = new CreateRentDto();
        createRentObject.amount_excluding = input.amountExcluding;
        createRentObject.created_at = new Date();
        createRentObject.rent_at = new Date();
        createRentObject.nb_days = input.nbDays;
        createRentObject.status_id = 1;// @todo('set input value') createRentObject.status_id = input.status.value;
        createRentObject.user_id = context.data.user.id;
        createRentObject.vat_rate = input.vatRate;
        createRentObject.vehicle_id = input.vehicleId;

        let rentCreated = await RentController.createRent(createRentObject);
        return {rent: rentCreated};
    },
})

export {createRentType}
