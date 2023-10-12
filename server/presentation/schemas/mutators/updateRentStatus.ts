import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLInt, GraphQLNonNull} from "graphql";
import RentController from "../../../domain/controllers/rentController";
import {rentType} from "../types/rentType";
import checkIsAdmin from "../checks/checkIsAdmin";
import checkIsRentOwner from "../checks/checkIsRentOwner";
import checkIsAuthenticated from "../checks/checkIsAuthenticated";


const updateRentStatusType = mutationWithClientMutationId({
    name: 'UpdateRentStatus',
    inputFields: {
        rentId: { type: GraphQLNonNull(GraphQLInt) },
        status: { type: GraphQLNonNull(GraphQLInt) }
    },
    outputFields: {
        rent: {type: rentType},
    },
    mutateAndGetPayload: async (input, context) => {
        checkIsAuthenticated(context); // Throw error if user is not authenticated
        await checkIsRentOwner(input.rentId, context.data.user.id); // Throw error if user is not the owner of the rent
        let rentUpdated = await RentController.updateRentStatus(input.rentId, input.status);
        return {rent: rentUpdated};
    },
})

export {updateRentStatusType}
