import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLError, GraphQLInt, GraphQLNonNull} from "graphql";
import RentController from "../../../domain/controllers/rentController";
import {rentType} from "../types/rentType";
import vehicleController from "../../../domain/controllers/vehicleController";
import CreateRentDto from "../../../data/models/dto/createRentDto";
import { statusType } from "../types/statusType";
import Status from "../../../domain/entities/status";


const createRentType = mutationWithClientMutationId({
    name: 'CreateRent',
    inputFields: {
        nbDays: { type: GraphQLNonNull(GraphQLInt) },
        amountExcluding: { type: GraphQLNonNull(GraphQLInt) },
        vatRate: { type: GraphQLNonNull(GraphQLInt) },
        vehicleId: { type: GraphQLNonNull(GraphQLInt) },
        userId: { type: GraphQLNonNull(GraphQLInt) },
        status: { type: GraphQLNonNull(statusType) },
    },
    outputFields: {
        rent: {type: rentType},
    },
    mutateAndGetPayload: async (input) => {
        let vehicle = await vehicleController.getById(input.vehicleId);
        if (vehicle == null) {
            throw new GraphQLError('Vehicle does not exist',
                null,
                null,
                null,
                null,
                null,
                { code: 'VEHICLE_DOES_NOT_EXIST', date: Date.now(), status: 400}
            );
        }
        let createRentObject = new CreateRentDto();
        createRentObject.amount_excluding = input.amountExcluding;
        createRentObject.created_at = new Date();
        createRentObject.rent_at = new Date();
        createRentObject.nb_days = input.nbDays;
        createRentObject.status_id = 1;// @todo('set input value') createRentObject.status_id = input.status.value;
        createRentObject.user_id = input.userId;
        createRentObject.vat_rate = input.vatRate;
        createRentObject.vehicle_id = input.vehicleId;

        let rentCreated = await RentController.createRent(createRentObject);
        return {rent: rentCreated};
    },
})

export {createRentType}