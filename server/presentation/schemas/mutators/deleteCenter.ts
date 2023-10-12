import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLInt, GraphQLNonNull, GraphQLString} from "graphql";
import checkIsAdmin from "../checks/checkIsAdmin";
import { centerType } from "../types/centerType";
import centerController from "../../../domain/controllers/centerController";


const deleteCenterType = mutationWithClientMutationId({
    name: 'DeleteCenter',
    inputFields: {
        centerId: { type: GraphQLNonNull(GraphQLInt) },
    },
    outputFields: {
        center: {type: centerType},
    },
    mutateAndGetPayload: async (input, context) => {
        checkIsAdmin(context); // Throw error if user is not admin
        let centerDeleted = await centerController.delete(input.centerId)
        return {center: centerDeleted};
    },
})

export {deleteCenterType};
